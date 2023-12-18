//
//  FirstSharedView.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI
import SwiftSoup


struct FirstSharedView: View {
    
    @State public var memoTitle: String = "" // 사용자가 입력할 제목을 저장할 상태 변수입니다.
    private let t_maxCharacterLimit = 30 //TODO : db varchar이라면 limit을 어떻게 잡을지 반영
    
    @State public var memoContent: String = "" // 사용자가 입력할 내용을 저장할 상태 변수입니다.
    private let c_maxCharacterLimit = 250
    
    @State private var showSecondView = false // 두 번째 화면 띄우는 토글
    private var linkURL : String // 링크 주소
    @State private var onClose : () -> Void // 화면 닫는 클로저
    @State private var image : UIImage
    
    @State private var isAddPopoverPresented = false // 태그 추가
    @State private var newTagTitle = ""
    @State private var newTagColor = Color.gray // 새로운 태그 색상
    @State private var emptyTagTitle = false
    
    @State private var selectedReminderPeriod = "1일"
    @State private var isReminderPeriodPopoverPresented = false// 주기 설정
    
    @State private var selectedTags: Set<TypeBubble> = [] //고른 태그 집합
    @State private var tagButtonList: [TypeBubble] //모든 태그 리스트
    
    @State private var presetPopup = false
    @State private var directSetPopup = false
    
    @State private var selectedPresets: Set<presetButton> = []
    @State private var presetButtonList: [presetButton]
    
    @State private var showAlert = false
    @State private var showEmptyTitleAlert = false//제목 무조건 0자 이상, 제목 중복 없어야 하면 나중에 추가 구현
    @State private var showTagAlert = false//태그 1개 이상 선택 안할시
    
    @ObservedObject var memoViewModel = MemoViewModel.shared
    @StateObject private var viewModel = AddMemoViewModel()
    @ObservedObject private var presetViewModel = AlarmPresetViewModel.shared
    
    // ContentView의 initializer 추가
    init(linkURL: String, image: UIImage, onClose: @escaping () -> Void, tagButtonList: [TypeBubble], presetButtonList: [presetButton]) {
        self.linkURL = linkURL
        self.image = image
        self.onClose = onClose
        self.tagButtonList = tagButtonList
        self.presetButtonList = presetButtonList
    }
    
    var body: some View {
        
        VStack {
            
            //header
            HStack {
                Spacer()
                Text("메모 등록")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.80))
                Spacer()
                Button(action: {
                    onClose()
                }) {
                    Image(systemName: "xmark")
                    
                        .foregroundColor(.black)
                }
            }.frame(height: 60)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
            
            //contents
            VStack(alignment: .leading, spacing: 30) {
                
                //제목
                VStack(alignment: .leading, spacing: 10) {
                    CardTitleText(title: "제목")
                    CardContent {
                        HStack{
                            TextField("메모 제목을 작성해주세요.", text: $memoTitle, axis: .vertical)
                                .font(.system(size: 12, weight: .medium))
                                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                .multilineTextAlignment(.leading)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, alignment: .center) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
                                .cornerRadius(10) // 코너 반경 설정
                                .onChange(of: memoTitle) { newValue in
                                    if newValue.count > t_maxCharacterLimit {
                                        memoTitle = String(newValue.prefix(t_maxCharacterLimit))
                                    }
                                }
                            
                            Text("\(memoTitle.count) / \(t_maxCharacterLimit)")
                                .font(.system(size: 12))
                                .foregroundColor(memoTitle.count == t_maxCharacterLimit ? .pink : .gray)
                                .cornerRadius(10)
                                .padding(.trailing, 10)
                            
                            
                        }
                        .background(.black.opacity(0.1))
                        .cornerRadius(10)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, alignment: .center)
                        
                    }
                }.frame(maxWidth: .infinity)
                
                //태그 스크롤
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            Text("메모 타입")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                            
                            Spacer()
                        }
                        HStack{
                            Text("선택시")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                            Text("\'보라색\'")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(hex: "#69314c"))
                            Text("으로 표시됩니다.")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                        }
                        
                    }
                    CardContent {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(tagButtonList, id: \.self) { typeBubble in
                                    Button(action: {
                                        // Add action for the button if needed
                                        if selectedTags.contains(typeBubble) {
                                            //                                            typeBubble.selected = false
                                            selectedTags.remove(typeBubble)
                                            
                                        } else {
                                            selectedTags.insert(typeBubble)
                                        }
                                    }) {
                                        TypeBubble(typeBubble.title, typeBubble.hexCode, selected: selectedTags.contains(typeBubble))
                                    }
                                }
                                Button(action: {
                                    isAddPopoverPresented.toggle()
                                }){
                                    addTypeBubble()
                                }
                                .popover(isPresented: $isAddPopoverPresented, attachmentAnchor: .rect(.bounds), arrowEdge: .bottom) {
                                    // 태그 추가 팝업창
                                    VStack {
                                        Text("새로운 태그 추가")
                                            .font(.headline)
                                            .padding()
                                        
                                        TextField("태그 제목", text: $newTagTitle)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .padding()
                                        
                                        ColorPicker("색상 선택", selection: $newTagColor, supportsOpacity: false)
                                            .padding()
                                        
                                        Button("확인") {
                                            // 새로운 태그를 만들어서 tagButtonList에 추가
                                            if newTagTitle.isEmpty{
                                                emptyTagTitle = true
                                            }
                                            else{
                                                let newTag = TypeBubble(newTagTitle, newTagColor.hexCode()) //TODO 태그의 색상은 기본값으로 설정
                                                tagButtonList.append(newTag)
                                                newTagTitle = "" // 새로운 태그 제목 초기화
                                                newTagColor = Color.gray
                                                isAddPopoverPresented.toggle()
                                            }
                                        }
                                        .padding()
                                    }.alert(isPresented: $emptyTagTitle) {//차후 이미 존재하는 태그들에 대해서 이슈가 있을 수 있음.
                                        Alert(
                                            title: Text("경고"),
                                            message: Text("빈 제목의 태그는 만들 수 없습니다."),
                                            dismissButton: .default(Text("확인")){
                                                showTagAlert = false
                                                showEmptyTitleAlert = false
                                            }
                                        )
                                    }
                                    .padding()
                                }
                            }
                        }
                    }
                }
            }.frame(maxWidth: .infinity)
            
            
            //url
            VStack(alignment: .leading, spacing: 10) {
                CardTitleText(title: "Link")
                CardContent {
                    HStack {
                        Text(linkURL)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.gray)
                    }
                }
            }.frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            
            //comment 입력
            VStack(alignment: .leading, spacing: 10) {
                CardTitleText(title: "메모 내용")
                CardContent {
                    // TextEditor의 스크롤 가능한 영역 설정
                    VStack(alignment: .leading, spacing: 0){
                        TextField("메모 디테일한 내용을 작성해주세요.", text: $memoContent, axis: .vertical)
                            .font(.system(size: 12, weight: .medium))
                            .padding(10)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120, alignment: .top) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
                            .background(.black.opacity(0.1)) // 배경색 설정
                            .cornerRadius(10) // 코너 반경 설정
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .onChange(of: memoContent) { newValue in
                                if newValue.count > c_maxCharacterLimit {
                                    memoContent = String(newValue.prefix(c_maxCharacterLimit))
                                }
                            }
                        
                        HStack {
                            Spacer()
                            Text("\(memoContent.count) / \(c_maxCharacterLimit)")
                                .font(.system(size: 12))
                                .foregroundColor(memoContent.count == c_maxCharacterLimit ? .pink : .gray)
                                .padding(.top, -23)
                                .padding(.trailing, 15)
                        }
                        
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            //alarm period
            VStack(alignment: .leading, spacing: 10) {
                MemoAlarmPresetFormView(
                    presetList: $presetViewModel.presets,
                    selectedReminder: $viewModel.selectedReminder,
                    isEditing: $viewModel.isEditing
                )
                
                CardContent {
                    VStack{
                        HStack {
                            Spacer()
                            
                            Button("등록하기") {
                                if selectedTags.isEmpty || memoTitle.isEmpty{
                                    if selectedTags.isEmpty {
                                        showTagAlert = true
                                    }
                                    if memoTitle.isEmpty{
                                        showEmptyTitleAlert = true
                                    }
                                    showAlert = true
                                }else {
                                    viewModel.memoType = ""
                                    viewModel.link = linkURL
                                    viewModel.memoTitle = memoTitle
                                    viewModel.memoContent = memoContent
                                    viewModel.selectedReminder = []
                                    viewModel.isEditing = true
                                    viewModel.tags = []
                                    viewModel.addNewMemo()
                                    showSecondView.toggle()
                                    
                                }
                            }
                            .font(.headline)
                            .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: 50))
                            .background(Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .popover(isPresented: $showSecondView, attachmentAnchor: .rect(.rect(CGRect(x: 0, y: 20,
                                                                                                        width: 160, height: 100))),
                                     arrowEdge: .top) {
                                SecondSharedView(onClose: $onClose, image: $image, selectedTags: $selectedTags, memoTitle: $memoTitle, memoContent: $memoContent, linkURL: linkURL)
                            }.fixedSize(horizontal: false, vertical: true)
                            
                        }
                    }.alert(isPresented: $showAlert) {
                        if(showTagAlert && showEmptyTitleAlert){
                            Alert(
                                title: Text("경고"),
                                message: Text("메모 제목을 입력해주세요.\n태그를 최소 1개 이상 선택해주세요."),
                                dismissButton: .default(Text("확인")){
                                    showTagAlert = false
                                    showEmptyTitleAlert = false
                                }
                            )
                        }
                        else if(showTagAlert){
                            Alert(
                                title: Text("경고"),
                                message: Text("태그를 최소 1개 이상 선택해주세요."),
                                dismissButton: .default(Text("확인")){
                                    showTagAlert = false
                                }
                            )
                        }
                        else{
                            Alert(
                                title: Text("경고"),
                                message: Text("메모 제목을 입력해주세요."),
                                dismissButton: .default(Text("확인")){
                                    showEmptyTitleAlert = false
                                }
                            )
                        }
                        
                    }
                    
                }
            }.frame(maxWidth: .infinity)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity)
        //        .overlay(RoundedRectangle(cornerRadius: 20))
        //        .stroke(Color.black, lineWidth: 1.0) // Optional: Add a border
        
        Spacer()
    }
}


