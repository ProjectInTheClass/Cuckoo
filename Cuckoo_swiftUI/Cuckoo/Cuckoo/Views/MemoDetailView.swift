//
//  MemoDetailView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/12.
//

import SwiftUI

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
        VStack {
            HeaderView(title: "메모 상세")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            Spacer()
            
            ScrollView(.vertical, showsIndicators:false) {
                VStack(alignment: .leading, spacing: 40) {
                    MemoThumbnailImageView(
                        memo: viewModel.memo,
                        width: .infinity,
                        height: 150
                    ).padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        MemoTitleView(
                            isEditing: $viewModel.isEditing,
                            editedTitle: $viewModel.memo.title
                        )
                        
                        TagsView(tags: dummyTags)
                    }
                    
                    if viewModel.memo.url != nil {
                        MemoLinkView(link: viewModel.memo.url)
                    }
                    
                    MemoContentView(
                        isEditing: $viewModel.isEditing,
                        Comment: $viewModel.memo.comment
                    )
                    
                    ReminderPickerView(
                        selectedReminder: $viewModel.selectedReminder,
                        isEditing: $viewModel.isEditing,
                        reminderOptions: viewModel.reminderOptions
                    )
                    
                    MemoInfoView(/*lastEdited: viewModel.memo.lastEdited*/)
                }.padding(.bottom, 20)
            }.padding(.horizontal, 30)
            
            
        }
        .overlay(
            EditButtonView(
                isEditing: $viewModel.isEditing,
                showActionButtons: $viewModel.showActionButtons,
                showDeleteAlert: $viewModel.showDeleteAlert,
                saveChanges: viewModel.saveChanges,
                deleteMemo: viewModel.deleteMemo)
                    .padding(.trailing, 15),
            alignment: .bottom)
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
        .navigationBarBackButtonHidden(true)
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
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.black)
                        .cornerRadius(15)
                }
            }
        }
    }
}

// Link View
struct MemoLinkView: View {
    var link: URL? // URL? 타입으로 변경

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("메모 링크")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                    
                    Spacer()
                }
                // TODO :: 수정기능?
                Text(link?.absoluteString ?? "")
                  .font(.system(size: 12, weight: .medium))
                  .underline()
                  .lineLimit(1)
                  .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                  .foregroundColor(Color.cuckooNormalGray)
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
                        // Handle the selected multiplier
                        // You can update your UI or perform other actions here
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
    var body: some View{
        VStack(alignment: .leading, spacing: 3) {
            Text("메모 정보")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            
            VStack {
                Text("생성 일자: 2023.10.21")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text("수정 일자: 2023.10.21")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
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
                        .background(Circle().fill(isEditing ? Color.green : Color.gray))
                        .foregroundColor(.black)
                        .shadow(radius: 3)
                }
                .padding()
            }
        }
        
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
            thumbURL: URL(string: "https://www.example.com"),
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

