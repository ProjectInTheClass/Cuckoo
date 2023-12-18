//
//  InitialView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import SwiftUI
import Combine

let defaults = UserDefaults.standard

struct Init_AddNameAndTagView: View {
    @ObservedObject var tagViewModel = TagViewModel.shared
    @ObservedObject var userViewModel = UserProfileViewModel.shared
    
    // 상태 관리를 위한 변수 추가
    @State private var showAddTagForm = false
    @State private var buttonText = "프로필 입력 완료!"
    @State private var headerTitle = "누구인지 알려주세요!"
    @State private var navigateToNextScreen = false
    @State private var needMoreTagAlert = false
    
    @State var username = "이름"
    var body: some View {
        NavigationView {
            VStack {
                // 헤더 제목을 상태 변수로 변경
                HeaderView(title: headerTitle, isRoot: true)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .center, spacing: 30) {
                    AddNameView(
                        username: $username
                    )
                        .frame(maxWidth: .infinity)//임시처리
                    
                    BarDivider()

                    // 조건에 따라 AddTagFormView 표시
                    if showAddTagForm {
                        AddTagFormView()
                            .frame(maxWidth: .infinity)
                    }
                    
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity)
                Spacer()
                
                NavigationLink(
                    destination: Init_AddAlarmPresetView(),
                    isActive: $navigateToNextScreen
                ) {
                    EmptyView()
                }

                // 버튼 클릭 시 액션 추가
                ConfirmFixedButton(confirmMessage: buttonText, logic: {
                    if !showAddTagForm {
                        withAnimation(Animation.easeInOut(duration: 0.3)) {
                            self.showAddTagForm.toggle()
                        }
                        self.buttonText = "태그 추가 완료"
                        self.headerTitle = "태그를 추가해주세요!"
                    } else {
                        // 다른 화면으로 이동
                        if tagViewModel.tags.count == 1 {
                            needMoreTagAlert.toggle()
                        }
                        else{
                            userViewModel.username = username;
                            self.navigateToNextScreen = true
                        }
                    }
                })
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                
                    
                    
            }
        }.alert(isPresented: $needMoreTagAlert) {
            Alert(
                title: Text("알림"),
                message: Text("적어도 태그 하나 이상 추가해주세요!"),
                dismissButton: .default(Text("확인")){
                    needMoreTagAlert = false
                }
            )
        }
    }
}

struct Init_AddNameAndTagView_Previews: PreviewProvider {
    static var previews: some View {
        Init_AddNameAndTagView()
    }
}

// Components
struct AddNameView: View {
    @Binding var username: String
    @FocusState private var isEditing: Bool

    func getUserName() -> String{
        return username
    }
    
    var body: some View {
            VStack(alignment: .center, spacing: 30) {
                CardContent {
                    VStack(spacing: 20) {
                        // TODO: 나중에 이미지 업로드 가능하게 변경 (Profile Image)
                        Image("DefaultPreview")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .cornerRadius(70)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.30))
                        
                        HStack {
                            Spacer()
                            TextField("", text: $username)
                                .focused($isEditing)
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                                .underline(isEditing)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: true, vertical: false)
                            Spacer()
                        }
                    }
                }
                
            }
        
    }
}

struct AddTagFormView: View {
    @ObservedObject var tagViewModel = TagViewModel.shared
    @State var isAddPopoverPresented = false
    
    @State var newTagTitle = ""
    @State var newTagColor = Color.gray
    
    @State var emptyTagTitle = false
    @State var showTagAlert = false
    @State var showEmptyTitleAlert = false
    
    @State var isEnabled = true
    
    init() {
        if tagViewModel.tags.isEmpty {
            tagViewModel.addTag(name: "전체", color: "6D25E0")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "등록된 메모 태그")
            CardContent {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tagViewModel.tags, id: \.self) { tag in
                            SettingTagBubble(tag: tag)
                        }
                        
                        AddButton(isEnabled: $isEnabled, logic: {
                            isAddPopoverPresented.toggle()
                        })
                        .popover(
                            isPresented: $isAddPopoverPresented,
                            attachmentAnchor: .rect(.bounds),
                            arrowEdge: .bottom) {
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
                                            tagViewModel.addTag(name: newTagTitle, color: newTagColor.hexCode())
                                            newTagTitle = "" // 새로운 태그 제목 초기화
                                            newTagColor = Color.gray
                                            isAddPopoverPresented.toggle()
                                        }
                                    }
                                    .padding()
                                }
                                .padding(.horizontal, 30)
                                .alert(isPresented: $emptyTagTitle) {//차후 이미 존재하는 태그들에 대해서 이슈가 있을 수 있음.
                                    Alert(
                                        title: Text("알림"),
                                        message: Text("빈 제목의 태그는 만들 수 없습니다."),
                                        dismissButton: .default(Text("확인")){
                                            showTagAlert = false
                                            showEmptyTitleAlert = false
                                        }
                                    )
                                }
                            }
                    }
                }
            }
        }
    }
}
