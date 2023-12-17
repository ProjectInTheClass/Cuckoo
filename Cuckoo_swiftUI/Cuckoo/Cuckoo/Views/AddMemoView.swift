//
//  AddMemoView.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/08.
//

import SwiftUI
import Combine


struct AddMemoView: View {
    @StateObject private var viewModel = AddMemoViewModel()
    @ObservedObject private var presetViewModel = AlarmPresetViewModel.shared
    
    @SwiftUI.Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack {
                HeaderView(title: "메모 등록")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 30) {
                        MemoTypeFormView(selectedTags: $viewModel.tags)
                            .frame(maxWidth: .infinity)
                        
                        MemoTitleFormView(
                            isEditing: $viewModel.isEditing,
                            editedTitle: $viewModel.memoTitle
                        )
                        
                        MemoUrlTypeFormView(link: $viewModel.link)
                            .frame(maxWidth: .infinity)
                        
                        MemoContentFormView(memoContent: $viewModel.memoContent)
                            .frame(maxWidth: .infinity)
                        
                        MemoAlarmPresetFormView(
                            presetList: $presetViewModel.presets,
                            selectedReminder: $viewModel.selectedReminder,
                            isEditing: $viewModel.isEditing
                        )
                            .frame(maxWidth: .infinity)
                        
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 100)
                    .padding(.horizontal, 30)
                    .frame(maxWidth: .infinity)
                }
                Spacer()
                
            }
            .overlay(
                AddMemoFooterView(
                    addMemoAction: {
                        viewModel.addNewMemo()
                        dismiss()
                    })
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                ,alignment: .bottom)
            .navigationBarBackButtonHidden(true)
    }
}

struct AddMemoView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemoView()
    }
}

// Components
struct MemoTypeFormView: View {
    @StateObject private var tagViewModel = TagViewModel.shared
    @Binding var selectedTags: [TagEntity]
    
    @State var isEnabled: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "메모 타입")
            CardContent {
                ScrollView(.horizontal, showsIndicators:false) {
                        HStack {
                            ForEach(selectedTags, id: \.self) { tag in
                                Button {
                                    withAnimation {
                                        if let index = selectedTags.firstIndex(of: tag) {
                                            selectedTags.remove(at: index) // 선택된 태그 제거
                                            isEnabled = selectedTags.count != tagViewModel.tags.count
                                        }
                                    }
                                } label: {
                                    TagNoEntireView(tag: tag)
                                }
                            }
                            Menu {
                                ForEach(tagViewModel.tags, id: \.self) { tag in
                                    
                                    if tag.name != "전체" {
                                                Button(tag.name) {
                                                    if !selectedTags.contains(tag) {
                                                        selectedTags.append(tag) // 중복되지 않는 경우에만 선택된 태그에 추가
                                                        isEnabled = selectedTags.count != tagViewModel.tags.count
                                                    }
                                                }.disabled(selectedTags.contains(tag))
                                            }
                                        }
                            } label: {
                                AddButton(isEnabled: $isEnabled, logic: {})
                            }
                        }
                }
                
            }
        }
    }
}



struct MemoTitleFormView: View {
    @Binding var isEditing: Bool
    @Binding var editedTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "메모 제목")
            if isEditing {
                TextField("제목", text: $editedTitle)
                    .font(.system(size: 24, weight: .bold))
                    .underline()
                
            } else {
                Text(editedTitle)
                    .font(.system(size: 24, weight: .bold))
                    .underline()
                
            }
        }
    }
}


struct MemoUrlTypeFormView: View {
    @Binding var link: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "메모 링크 (Optional)")
            CardContent {
                TextField("링크 입력해주세요!", text: $link)
                    .font(.system(size: 12, weight: .medium))
                    .underline()
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .foregroundColor(Color.cuckooNormalGray)
                    .onTapGesture {
                        pasteFromClipboard()
                    }
            }
        }
    }

    private func pasteFromClipboard() {
        if let clipboardString = UIPasteboard.general.string {
            // 클립보드의 문자열이 유효한 URL인지 확인
            if URL(string: clipboardString) != nil {
                link = clipboardString
            }
        }
    }
}



struct MemoContentFormView: View {
    @Binding var memoContent: String // 사용자가 입력할 내용을 저장할 상태 변수입니다.
    
    private let maxCharacterLimit = 250
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CardTitleText(title: "메모 내용")
            CardContent {
                // TextEditor의 스크롤 가능한 영역 설정
                VStack(alignment: .leading, spacing: 0){
                    TextField("메모 디테일한 내용을 작성해주세요.", text: $memoContent, axis: .vertical)
                        .font(.system(size: 14, weight: .medium))
                        .padding(15)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 140, alignment: .top) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
                        .background(Color.cardBackground) // 배경색 설정
                        .cornerRadius(10) // 코너 반경 설정
                        .onReceive(memoContent.publisher.collect()) {
                            // 입력된 텍스트 길이 확인
                            if $0.count > maxCharacterLimit {
                                memoContent = String($0.prefix(maxCharacterLimit))
                            }
                        }
                    
                    HStack {
                        Spacer()
                        Text("\(memoContent.count) / \(maxCharacterLimit)")
                            .font(.system(size: 12))
                            .foregroundColor(memoContent.count == maxCharacterLimit ? .pink : .gray)
                            .padding(.top, -23)
                            .padding(.trailing, 15)
                    }
                    
                }.onAppear (perform : UIApplication.shared.hideKeyboard)
            }
        }
    }
}

struct MemoAlarmPresetFormView: View {
    @Binding var presetList: [AlarmPresetEntity]
    @Binding var selectedReminder: AlarmPresetEntity?
    @Binding var isEditing: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("알람 시기 설정")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }
                Text("언제 알림받는게 좋을까요?")
                  .font(.system(size: 12, weight: .medium))
                  .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
            }
            CardContent {
                
                if isEditing {
                    Menu {
                        ForEach(presetList, id: \.self) { preset in
                            Button("\(preset.icon) \(preset.name)") {
                                selectedReminder = preset
                            }
                        }
                    } label: {
                        if let selectedReminder = selectedReminder {
                            PresetButtonView(preset: selectedReminder, onToggle: {}, isSelected: false)
                        } else {
                            PresetButtonView(preset: presetList[0], onToggle: {
                                selectedReminder = presetList[0]
                            }, isSelected: false)
                        }
                    }
                } else {
                    if let selectedReminder = selectedReminder {
                        PresetButtonView(preset: selectedReminder, onToggle: {}, isSelected: false)
                    } else {
                        PresetButtonView(preset: presetList[0], onToggle: {
                            selectedReminder = presetList[0]
                        }, isSelected: false)
                    }
                }
                
                
            }
        }
    }
}

struct MemoPreView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("미리보기")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }
                Text("다음처럼 보일 예정이에요.")
                  .font(.system(size: 12, weight: .medium))
                  .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
            }
            CardContent {
                // TextEditor의 스크롤 가능한 영역 설정
                Rectangle()
                .foregroundColor(.clear)
                .frame(maxWidth: .infinity, maxHeight: 0.5)
                .background(.black.opacity(0.2))
            }
        }
    }
}

struct AddMemoFooterView: View {
    var addMemoAction: () -> Void
    var body: some View {
        VStack {
            Button(action: addMemoAction) {
                Text("작성 완료")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.purple)
        .cornerRadius(15)
        .padding(.horizontal, 30)

    }
}


struct CardContent<Content: View>: View {
    var child: Content
    init(@ViewBuilder content: () -> Content) {
        self.child = content()
    }
    
    var body: some View {
        child
    }
}

struct CardTitleText: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            Spacer()
        }
    }
}

struct TypeBubble: View {
    var title: String
    var hexCode: String
    
    init(_ title: String, _ hexCode: String){
        self.title = title
        self.hexCode = hexCode
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.black.opacity(0.7))
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(Color(hex: hexCode))
            .cornerRadius(15)
    }
}

struct InfoBubble: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(.white)
            .padding(6)
            .background(Color.red)
            .clipShape(Circle()) // 원형 모양으로 만듭니다.
    }
}

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: cleanedHex).scanHexInt64(&rgb)

        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}

struct TextFormView: View {
    // Properties
    @State private var text: String = ""
    @State private var placeholder: String = "메모 디테일한 내용을 작성해주세요."
    private let maxCharacterLimit = 500

    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(text.isEmpty ? .white : .black)
                    .onTapGesture {
                        if self.text == placeholder {
                            self.text = ""
                        }
                    }
                    .onChange(of: text) { newValue in
                        if text.count > maxCharacterLimit {
                            text = String(text.prefix(maxCharacterLimit))
                        }
                    }
                    .background(.black.opacity(0.7))
            }
            .frame(height: 120)

            HStack {
                Spacer()
                Text("\(text.count) / \(maxCharacterLimit)")
                    .font(.system(size: 12))
                    .foregroundColor(text.count == maxCharacterLimit ? .pink : .gray)
                    .padding(.trailing, 0)
            }
            
        }
        .onTapGesture {
            hideKeyboard()
        }
        
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
