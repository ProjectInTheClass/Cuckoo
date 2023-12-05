//
//  MemoDetailView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/12.
//

import SwiftUI

// Header View
struct MemoDetailHeaderView: View {
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    
                    .foregroundColor(.black)
            }
            Spacer()
            Text("메모 상세")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black.opacity(0.80))
            Spacer()
        }
    }
}

// Image View
struct MemoImageView: View {
    var body: some View {
        Image("model_s")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .padding(.bottom, 30)
            
                                        
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
    let tags: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag)
                }
            }
            
        }
        .padding(.bottom, 30)
    }
}

// Tag View
struct TagView: View {
    var tag: String
    
    var body: some View {
        Text(tag)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.gray.opacity(0.2))
            .foregroundColor(.black)
            .cornerRadius(15)
    }
}

// Link View
struct MemoLinkView: View {
    var link: URL? // URL? 타입으로 변경

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("메모 링크")
            Text(link?.absoluteString ?? "") // URL을 문자열로 표시
                .foregroundColor(.gray)
        }
        .padding(.bottom, 30)
    }
}

// Content View
struct MemoContentView: View {
    @Binding var isEditing: Bool
    @Binding var Comment: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("메모 내용")
            ZStack(alignment: .bottomTrailing) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2)) // 상자 안의 색상 설정
                    .frame(height: 100) // 상자의 높이를 지정
                   
                
                
                if isEditing {
                    // 여러 줄의 코멘트를 입력받을 TextEditor
                    TextEditor(text: $Comment)
                        .padding(4) // TextEditor 내부 패딩
                        .frame(minHeight: 100) // TextEditor의 최소 높이를 지정
                        .cornerRadius(8) // 모서리를 둥글게
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                       
                        .foregroundColor(Color.gray)
                    
                } else {
                    // 편집 모드가 아닐 때 일반 텍스트 표시
                    HStack {
                        Text(Comment)
                            .foregroundColor(Color.gray.opacity(1.0))
                            .padding(4)
                        Spacer() // 이 Spacer로 인해 Text 뷰는 왼쪽에 정렬됩니다.
                    }
                    .frame(minHeight: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    
                }
                
                // 글자 수 표시 (편집 모드일 때만)
                if isEditing {
                    Text("\(Comment.count) / 250")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing, 35)
                        .padding(.bottom, 8)
                }
            }
        }
        .padding(.bottom, 30)
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
    let reminderOptions: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("알람 주기 설정")
            Text("푸쉬 알림으로 반복해서 리마인드 할 주기!")
                .font(.footnote)
                .foregroundColor(.gray)
            Menu {
                Picker("알람 주기 선택", selection: $selectedReminder) {
                    ForEach(reminderOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
            } label: {
                HStack {
                    Text("알람 주기: \(selectedReminder)")
                        .foregroundColor(.black)
                    
                    
                }}.padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }.padding(.bottom, 30)
        
    }
    
}

struct MemoInfoView: View{
    var body: some View{
        VStack(alignment: .leading) {
                                   Text("메모 정보")
                                       
                                
                                   Text("생성일자 / 최근 알림일")
                                       .font(.footnote)
                                       .foregroundColor(.gray)
                                       
                                   Text("2023.10.21 / 2023.11.22 18:00")
                                       .font(.footnote)
                                       .foregroundColor(.gray)
                                       
                               }
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
                        .background(Circle().fill(Color.gray))
                        .foregroundColor(.black)
                        .shadow(radius: 3)
                }
                .padding()
            }
        }
        
    }
}

struct OptionsView: View {
    // 상태 변수 및 함수는 MemoDetailView에서 넘겨받거나 전역적으로 관리해야 합니다.
    var body: some View {
        VStack {
            Button("수정") {
                // 수정 로직
                // 예: isEditing 상태를 변경하여 편집 모드로 전환
            }
            .padding()
            
            Button("삭제") {
                // 삭제 로직
                // 예: deleteMemo 함수 호출
            }
            .padding()
        }
    }
}


// MemoDetailView
struct MemoDetailView: View {
    // State variables
    @State private var isEditing = false
    @State private var editedTitle = "HYU LMS"
    @State private var editedComment = "기존 코멘트"
    @State private var showDeleteAlert = false
    @State private var showActionButtons = false
    @State private var selectedReminder = "7일"
    @StateObject var viewModel: MemoDetailViewModel
    // Constants
    let reminderOptions = ["없음", "7일", "14일", "21일"]
    let tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5"]

    var body: some View {
            ZStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        // 각 서브뷰에 ViewModel 바인딩
                        MemoDetailHeaderView()
                        MemoImageView()
                        MemoTitleView(isEditing: $viewModel.isEditing, editedTitle: $viewModel.memo.title)
                        TagsView(tags: tags)
                        MemoLinkView(link: viewModel.memo.url)
                        MemoContentView(isEditing: $viewModel.isEditing, Comment: $viewModel.memo.comment)
                        ReminderPickerView(selectedReminder: $viewModel.selectedReminder, reminderOptions: viewModel.reminderOptions)
                        MemoInfoView(/*lastEdited: viewModel.memo.lastEdited*/)
                    }
                    .padding(.horizontal, 30)
                }
                EditButtonView(isEditing: $viewModel.isEditing, showActionButtons: $viewModel.showActionButtons, showDeleteAlert: $viewModel.showDeleteAlert, saveChanges: viewModel.saveChanges, deleteMemo: viewModel.deleteMemo)
            }
            .alert(isPresented: $viewModel.showDeleteAlert) {
                Alert(
                    title: Text("삭제 확인"),
                    message: Text("이 메모를 삭제하시겠습니까?"),
                    primaryButton: .destructive(Text("삭제")) {
                        viewModel.deleteMemo()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    
    func saveChanges() {
        // Implement your save changes logic here
        print("Changes saved")
    }
    
    func deleteMemo() {
        // Implement your delete memo logic here
        print("Memo deleted")
    }
}





struct MemoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // 더미 데이터 생성
        let dummyMemo = Memo(
            id: 1, // id 추가 (예시로 1을 사용)
            userId: 1, // userId 추가 (예시로 1을 사용)
            title: "Sample Memo",
            comment:"This is a sample memo.",
            url: URL(string: "https://www.example.com"),
            notificationCycle: 7, // 예시 값
            notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
            notificationStatus: "Active", // 예시 상태
            notificationCount: 3, // 예시 횟수
            isPinned: false, // 예시 고정 상태
            createdAt: Date(),
            updatedAt: Date(),
            remainingNotificationTime: Date() // 예시 남은 알림 시간
        )


        // 더미 데이터를 사용하여 ViewModel 인스턴스 생성
        let viewModel = MemoDetailViewModel(memo: dummyMemo)

        // 생성된 ViewModel을 사용하여 MemoDetailView 렌더링
        MemoDetailView(viewModel: viewModel)
    }
}

