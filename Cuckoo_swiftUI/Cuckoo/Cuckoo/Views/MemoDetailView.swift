//
//  MemoDetailView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/12.
//

import SwiftUI

struct MemoDetailHeaderView: View {
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                }) {
                    Image(systemName: "chevron.left")
                        .padding(.leading, 30)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("메모 상세")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
                Button(action: {}) {
                    Image(systemName: "chevron.left").opacity(0)
                        .padding(.leading, 30)
                }
                .foregroundColor(.gray)
                Spacer()
            }
        }
    }
}

struct MemoDetailView: View {
    let tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5"]
    @State private var isEditing = false // 편집 모드 상태 관리
    @State private var editedTitle = "HYU_LMS"
    @State private var editedComment = "기존 코멘트"
    @State private var showDeleteAlert = false
    @State private var showActionButtons = false // 액션 버튼 표시 여부
    
    var body: some View {
        ZStack {
            
            VStack {
                
                MemoDetailHeaderView()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Image("model_s")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 30)
                        VStack(alignment: .leading){
                            if isEditing {
                                TextField("제목", text: $editedTitle)
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(.horizontal, 30)
                            }
                            else {
                                // 편집 모드가 아닐 때 일반 텍스트 표시
                                Text(editedTitle)
                                    .font(.system(size: 22, weight: .bold))
                                    .padding(.horizontal, 30)
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(tags, id: \.self) { tag in
                                        TagView(tag: tag)
                                    }
                                }
                                
                            }.padding(.horizontal, 30)
                        }.padding(.bottom, 30)
                        VStack(alignment: .leading){
                            Text("메모 링크")
                                .padding(.horizontal, 30)
                            Text("www.examplelink.com")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 30)
                        }.padding(.bottom, 30)
                        VStack(alignment: .leading) {
                            Text("메모 내용")
                                .padding(.horizontal, 30)
                            
                            ZStack(alignment: .bottomTrailing) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2)) // 상자 안의 색상 설정
                                    .frame(height: 100) // 상자의 높이를 지정
                                    .padding(.horizontal, 30)
                                
                                
                                if isEditing {
                                    // 여러 줄의 코멘트를 입력받을 TextEditor
                                    TextEditor(text: $editedComment)
                                        .padding(4) // TextEditor 내부 패딩
                                        .frame(minHeight: 100) // TextEditor의 최소 높이를 지정
                                        .cornerRadius(8) // 모서리를 둥글게
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                        .padding(.horizontal, 30)
                                        .foregroundColor(Color.gray)
                                    
                                } else {
                                    // 편집 모드가 아닐 때 일반 텍스트 표시
                                    HStack {
                                        Text(editedComment)
                                            .foregroundColor(Color.gray.opacity(1.0))
                                            .padding(4)
                                        Spacer() // 이 Spacer로 인해 Text 뷰는 왼쪽에 정렬됩니다.
                                    }
                                    .frame(minHeight: 100)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                                    .padding(.horizontal, 30)
                                }
                                
                                // 글자 수 표시 (편집 모드일 때만)
                                if isEditing {
                                    Text("\(editedComment.count) / 250")
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
                        
                        
                        
                        
                        VStack(alignment: .leading) {
                            Text("알람 주기 설정")
                                .padding(.horizontal, 30)
                            
                            Text("푸쉬 알림으로 반복해서 리마인드 할 주기!")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 30)
                        }
                    }
                }
                
            }
            VStack {
                Spacer()
                
                // 수정과 삭제 버튼
                if showActionButtons {
                    HStack {
                        Spacer()
                        VStack {
                            // 편집 버튼
                            if !isEditing {
                                Button(action: {
                                    isEditing = true
                                }) {
                                    Image(systemName: "pencil")
                                        .padding()
                                        .background(Circle().fill(Color.gray)) // 배경색 변경
                                        .foregroundColor(.black) // 아이콘 색상 변경
                                        .shadow(radius: 3)
                                }
                            }
                            
                            // 삭제 버튼
                            if !isEditing {
                                Button(action: {
                                    showDeleteAlert = true
                                    showActionButtons = false
                                }) {
                                    Image(systemName: "trash")
                                        .padding()
                                        .background(Circle().fill(Color.gray)) // 배경색 변경
                                        .foregroundColor(.black) // 아이콘 색상 변경
                                        .shadow(radius: 3)
                                }
                            }
                        }.padding(.horizontal, 20)
                    }
                }
                
                // 메인 액션 버튼
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
                        Image(systemName: showActionButtons ? (isEditing ? "checkmark.circle" : "xmark.circle") : "pencil.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .background(Circle().fill(Color.gray)) // 배경색 변경
                            .foregroundColor(.black) // 아이콘 색상 변경
                            .shadow(radius: 3)
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showDeleteAlert) {
                // 삭제 확인 대화 상자 구성
                Alert(
                    title: Text("삭제 확인"),
                    message: Text("이 메모를 삭제하시겠습니까?"),
                    primaryButton: .destructive(Text("삭제")) {
                        deleteMemo()
                    },
                    secondaryButton: .cancel()
                )
            }
            
        }
        
    }
    
    
    
    struct TagView: View {
        var tag: String
        
        var body: some View {
            Text(tag)
                .font(.caption)
                .padding(.horizontal, 30)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(15)
        }
    }
    
    struct MemoDetailView_Previews: PreviewProvider {
        static var previews: some View {
            MemoDetailView()
        }
        
    }
    func saveChanges() {
        // TODO: 변경된 데이터를 데이터베이스에 저장하는 로직 구현
        // 예: API 호출, 로컬 데이터베이스 업데이트 등
    }
    
    func deleteMemo() {
        // TODO: 메모 삭제 로직 구현
        // 예: 데이터베이스에서 삭제, 로컬 저장소에서 제거 등
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
}
