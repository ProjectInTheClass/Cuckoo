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
    @State private var editedTitle = "기존 제목"
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
                    VStack(alignment: .leading, spacing: 40) {
                        Image("model_s")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                            .padding(.vertical, 30)
                        VStack(alignment: .leading){
                            if isEditing {
                                TextField("제목", text: $editedTitle)
                                    .font(.largeTitle)
                                    .padding(.horizontal, 30)
                            }
                            else {
                                // 편집 모드가 아닐 때 일반 텍스트 표시
                                Text(editedTitle)
                                    .font(.largeTitle)
                                    .padding(.horizontal, 30)
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(tags, id: \.self) { tag in
                                        TagView(tag: tag)
                                    }
                                }
                                
                            }.padding(.horizontal, 30)
                        }
                        VStack(alignment: .leading){
                            Text("메모 링크")
                                .padding(.horizontal, 30)
                            Text("www.examplelink.com")
                                .foregroundColor(.gray)
                                .padding(.horizontal, 30)
                        }
                        VStack(alignment: .leading) {
                                    Text("메모 내용")
                                        .padding(.horizontal, 30)

                                    ZStack(alignment: .bottomTrailing) {
                                        if isEditing {
                                            TextField("코멘트", text: $editedComment)
                                                .padding(10) // TextField 내부 패딩
                                                .frame(height: 100) // 상자의 높이를 지정
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.gray, lineWidth: 1) // 테두리 색상 및 두께
                                                )
                                                .padding(.horizontal, 30)
                                        } else {
                                            Text(editedComment)
                                                .padding(10) // Text 내부 패딩
                                                .frame(height: 100) // 상자의 높이를 지정
                                                .background(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.gray, lineWidth: 1) // 테두리 색상 및 두께
                                                )
                                                .padding(.horizontal, 30)
                                        }

                                        // 글자 수 표시
                                        Text("\(editedComment.count) / 250")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                            .padding(30)
                                    }
                                }
                        
                        
                        
                        Text("메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 30)
                    }
                }
                
            }
            VStack {
                Spacer()
                
                // 수정과 삭제 버튼이 토글될 때 나타나는 액션 버튼들
                if showActionButtons {
                                HStack {
                                    Spacer()
                                    VStack {
                                        // 편집 버튼
                                        if !isEditing {
                                            Button(action: {
                                                // 편집 모드로 전환
                                                isEditing = true
                                            }) {
                                                Image(systemName: "pencil")
                                                    .padding()
                                                    .background(Circle().fill(Color.white))
                                                    .shadow(radius: 3)
                                            }
                                        }
                                        
                                        // 삭제 버튼
                                        if !isEditing {
                                            Button(action: {
                                                // 삭제 확인 대화 상자 표시
                                                showDeleteAlert = true
                                                showActionButtons = false
                                            }) {
                                                Image(systemName: "trash")
                                                    .padding()
                                                    .background(Circle().fill(Color.white))
                                                    .shadow(radius: 3)
                                            }
                                        }
                                    }.padding(.horizontal,20)
                                }
                            }
                            
                            // 메인 액션 버튼
                            HStack {
                                Spacer()
                                Button(action: {
                                    // 액션 버튼 표시 여부를 토글
                                    withAnimation {
                                        if isEditing {
                                            // 저장 로직을 수행하고 편집 모드를 종료
                                            saveChanges()
                                            isEditing = false
                                        }
                                        showActionButtons.toggle()
                                    }
                                }) {
                                    Image(systemName: showActionButtons ? (isEditing ? "checkmark.circle" : "xmark.circle") : "pencil.circle")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .background(Circle().fill(Color.white))
                                        .shadow(radius: 3)
                                }
                                .padding()
                            }
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
