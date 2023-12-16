//
//  MemoDetailView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/12.
//

import SwiftUI
import CoreData

// MemoDetailView
struct MemoDetailView: View {
    // State variables
    @State private var isEditing = false
    @State private var showDeleteAlert = false
    @State private var showActionButtons = false
    @State private var selectedReminder = "7일"
    @StateObject var viewModel: MemoDetailViewModel
    
    var title: String
    var comment: String
    var url: URL?
    var thumbURL: URL?
    var noti_cycle: Int32
    var noti_preset: AlarmPresetEntity?
    var noti_count: Int32
    
    @SwiftUI.Environment(\.dismiss) var dismiss
    // Constants
    let reminderOptions = ["없음", "7일", "14일", "21일"]

    var body: some View {
        VStack {
            HeaderView(title: "메모 상세")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators:false) {
                VStack(alignment: .leading, spacing: 40) {
                    MemoThumbnailImageView(
                        width: .infinity,
                        height: 150,
                        thumbURL: thumbURL,
                        url: url
                    ).padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        MemoTitleView(
                            isEditing: $viewModel.isEditing,
                            editedTitle: $viewModel.memo.title
                        )
                        
                        TagsView(tags: viewModel.tags)
                    }
                    
                    MemoLinkView(
                        link: $viewModel.memo.url,
                        isEditing: $viewModel.isEditing
                    )
                    
                    MemoContentView(
                        isEditing: $viewModel.isEditing,
                        Comment: $viewModel.memo.comment
                    )
                    
                    ReminderPickerView(
                        selectedReminder: $viewModel.selectedReminder,
                        isEditing: $viewModel.isEditing,
                        reminderOptions: viewModel.reminderOptions
                    )
                    
                    // MemoDetailView에서 MemoInfoView 호출 부분
                    MemoInfoView(createdAt: viewModel.memo.created_at, updatedAt: viewModel.memo.updated_at)

                }.padding(.bottom, 20)
            }
            .onAppear(perform : UIApplication.shared.hideKeyboard)
            .padding(.horizontal, 30)
            
            
        }
        .overlay(
            EditButtonView(
                isEditing: $viewModel.isEditing,
                showActionButtons: $viewModel.showActionButtons,
                showDeleteAlert: $viewModel.showDeleteAlert,
                saveChanges: {
                    viewModel.saveChanges()
                },
                deleteMemo: viewModel.deleteMemo)
                    .padding(.trailing, 15),
            alignment: .bottom)
        .alert(isPresented: $viewModel.showDeleteAlert) {
            Alert(
                title: Text("삭제 확인"),
                message: Text("이 메모를 삭제하시겠습니까?"),
                primaryButton: .destructive(Text("삭제")) {
                    // TODO :: CoreData에 있는 MemoEntity의 id를 deleteMemo에 넘기기
                    // CoreData Entity에 id를 어떻게 넘겨야 하는지 몰라서 작성
                    viewModel.deleteMemo()
                    
                    dismiss()
                },
                secondaryButton: .cancel()
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}



// Title View
struct MemoTitleView: View {
    @Binding var isEditing: Bool
    @Binding var editedTitle: String
    
    var body: some View {
        if isEditing {
            TextField("제목", text: $editedTitle)
                .font(.system(size: 30, weight: .bold))
                
            
        } else {
            Text(editedTitle)
                .font(.system(size: 30, weight: .bold))
                
        }
    }
}

// Tags View
struct TagsView: View {
    let tags: [Tag]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags) { tag in
                    Text(tag.name)
                        .font(.caption.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.fromHex(tag.color))
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
            }
        }
    }
}

// Link View
struct MemoLinkView: View {
    @Binding var link: URL?
    @Binding var isEditing: Bool
    @State private var linkString: String = ""
    @FocusState private var isTyping: Bool

    
    private func pasteFromClipboard() {
        if let clipboardString = UIPasteboard.general.string {
            // 클립보드의 문자열이 유효한 URL인지 확인
            if URL(string: clipboardString) != nil {
                linkString = clipboardString
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("메모 링크")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }

                if isEditing {
                    // 수정 가능한 텍스트 필드
                    TextField("링크 입력해주세요!", text: $linkString)
                        .font(.system(size: 12, weight: .medium))
                        .focused($isTyping)
                        .underline()
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(Color.gray)
                        .onTapGesture {
                            if !isTyping{
                                pasteFromClipboard()
                            }
                        }
                        .onChange(of: linkString) { newValue in
                            self.link = URL(string: newValue)
                        }
                        .onAppear {
                            // 편집 모드에 진입할 때 URL을 문자열로 변환
                            self.linkString = self.link?.absoluteString ?? ""
                        }
                } else {
                    // Link 뷰
                    if let url = link {
                        Link(destination: url) {
                            Text(url.absoluteString)
                                .font(.system(size: 12, weight: .medium))
                                .underline()
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(Color.gray)
                        }
                    } else {
                        TextField("링크 입력해주세요!", text: $linkString)
                            .font(.system(size: 12, weight: .medium))
                            .underline()
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(Color.cuckooNormalGray)
                            .disabled(true)
                    }
                }
            }
        }
    }
}

// Content View
struct MemoContentView: View {
    @Binding var isEditing: Bool
    @Binding var Comment: String
    
    
    private let maxCharacterLimit: Int = 250
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("메모 내용")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            // TextEditor의 스크롤 가능한 영역 설정
            VStack(alignment: .leading, spacing: 0){
                TextField("메모 디테일한 내용을 작성해주세요.", text: $Comment, axis: .vertical)
                    .disabled(!isEditing)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(isEditing ? .black : Color.cuckooDeepGray)
                    .padding(15)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 140, alignment: .top) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
                    .background(Color.gray.opacity(0.2)) // 배경색 설정
                    .cornerRadius(10) // 코너 반경 설정
                    .onReceive(Comment.publisher.collect()) {
                        // 입력된 텍스트 길이 확인
                        if $0.count > maxCharacterLimit {
                            Comment = String($0.prefix(maxCharacterLimit))
                        }
                    }
                
                HStack {
                    Spacer()
                    Text("\(Comment.count) / \(maxCharacterLimit)")
                        .font(.system(size: 12))
                        .foregroundColor(Comment.count == maxCharacterLimit ? .pink : .gray)
                        .padding(.top, -23)
                        .padding(.trailing, 15)
                }
                
            }.onAppear (perform : UIApplication.shared.hideKeyboard)
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
   
        
    }
}

// Reminder Picker View
struct ReminderPickerView: View {
    @Binding var selectedReminder: String
    @Binding var isEditing: Bool
    
    let reminderOptions: [String]
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text("알람 주기 설정")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }
                Text("푸시 알림으로 반복해서 리마인드할 주기!")
                  .font(.system(size: 12, weight: .medium))
                  .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
            }
            CardContent {
                PickerView(isEditing: $isEditing)
            }
        }
    }
    
}

struct PickerView: View {
    @Binding var isEditing: Bool
    
    @State private var selectedReminderPeriod = "1일"
    @State private var isReminderPeriodPopoverPresented = false
    
    @State private var selectedMultiplier = 2
    @State private var isMultiplierPopoverPresented = false
    
    let PeriodOptions = ["1일", "2일", "3일", "4일", "5일", "6일", "1주", "2주", "3주", "4주", "8주"]
    
    var body: some View {
        HStack(alignment: .center) {
            Button("\(selectedReminderPeriod) 주기") {
                // Handle button tap
                if isEditing {
                    isReminderPeriodPopoverPresented.toggle()
                }
                    
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
            .background(.thickMaterial)
            .foregroundColor(.black)
            .cornerRadius(10)
            .popover(isPresented: $isReminderPeriodPopoverPresented) {
                VStack {
                    Text("알림 주기 선택")
                        .font(.headline)
                        .padding()
                    
                    // Add the Picker code here to select the reminder period
                    Picker("알림 주기", selection: $selectedReminderPeriod) {
                        ForEach(PeriodOptions, id: \.self) { period in
                            Text("\(period)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                    
                    Button("확인") {
                        isReminderPeriodPopoverPresented.toggle()
                    }
                }
            }
            
            
            Spacer()
            Button("\(selectedMultiplier)배수 증가") {
                if isEditing {
                    isMultiplierPopoverPresented.toggle()
                }
            }
            .font(.headline)
            .padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
            .background(.thickMaterial)
            .foregroundColor(.black)
            .cornerRadius(10)
            .popover(isPresented: $isMultiplierPopoverPresented) {
                VStack {
                    Text("배수 선택")
                        .font(.headline)
                        .padding()
                    
                    // Add the Picker code here to select the multiplier
                    Picker("배수", selection: $selectedMultiplier) {
                        ForEach(1...7, id: \.self) { multiplier in
                            Text("\(multiplier)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding()
                    
                    Button("확인") {
                        isMultiplierPopoverPresented.toggle()
                    }
                    .padding()
                }
            }
            Spacer()
        }
    }
}


struct MemoInfoView: View{
    let createdAt: Date?
    let updatedAt: Date?
    var body: some View{
        VStack(alignment: .leading, spacing: 3) {
            Text("메모 정보")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            
            VStack {
                Text("생성 일자: \(formattedDate(date: createdAt) ?? "정보 없음")")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("수정 일자: \(formattedDate(date: updatedAt) ?? "정보 없음")")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func formattedDate(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd HH:mm:ss"

        return dateFormatter.string(from: date)
    }
}

struct EditButtonView: View {
    @Binding var isEditing: Bool
    @Binding var showActionButtons: Bool
    @Binding var showDeleteAlert: Bool
    var saveChanges: () -> Void
    var deleteMemo: () -> Void

    var body: some View {
        VStack {
            Spacer()

            if showActionButtons {
                HStack {
                    Spacer()
                    VStack {
                        if !isEditing {
                            Button(action: {
                                print("toggled")
                                isEditing = true
                            }) {
                                Image(systemName: "pencil")
                                    .padding()
                                    .background(Circle().fill(Color.gray))
                                    .foregroundColor(.black)
                                    .shadow(radius: 3)
                            }
                        }

                        if !isEditing {
                            Button(action: {
                                showDeleteAlert = true
                                showActionButtons = false
                            }) {
                                Image(systemName: "trash")
                                    .padding()
                                    .background(Circle().fill(Color.gray))
                                    .foregroundColor(.black)
                                    .shadow(radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }.onAppear {
                    print("hihi")
                }
            }
                

            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        if isEditing {
                            saveChanges()
                            isEditing = false
                        }
                        showActionButtons.toggle()
                    }
                }) {
                    Image(systemName: showActionButtons ? (isEditing ? "checkmark" : "xmark") : "pencil")
                        .frame(width: 60, height: 60)
                        .background(Circle().fill(isEditing ? Color.green : Color.gray))
                        .foregroundColor(.black)
                        .shadow(radius: 3)
                }
                .padding()
            }
        }
        
    }
}
