//
//  MemoDetailView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/12.
//

import SwiftUI

struct MemoDetailView: View {
    let tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5"]
    @State private var isEditing = false // 편집 모드 상태 관리
    @State private var editedTitle = "기존 제목"
        @State private var editedComment = "기존 코멘트"

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                }) {
                    Image(systemName: "chevron.left")
                }
                .foregroundColor(.gray)
                // 상세 텍스트 가운데로 오게 하려고 더미 아이콘추가
                                Button(action: {}) {
                                    Image(systemName: "chevron.left").opacity(0)
                                }
                                .foregroundColor(.gray)
                Spacer()
                
                Text("상세")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()

                if !isEditing {
                                    Button(action: {
                                        isEditing = true
                                    }) {
                                        Image(systemName: "pencil")
                                    }
                                    .foregroundColor(.gray)
                                }

                                // 편집 모드가 활성화되면 확인 버튼 표시
                                if isEditing {
                                    Button(action: {
                                        saveChanges()
                                        isEditing = false
                                    }) {
                                        Text("확인")
                                    }
                                    .foregroundColor(.blue)
                                }
                
                Button(action: {
                }) {
                    Image(systemName: "trash")
                }
                .foregroundColor(.gray)
            }
            .padding(.horizontal, 30)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 40) {
                    Image("model_s")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 30)
                    
                    Text("www.examplelink.com")
                        .foregroundColor(.gray)
                        .padding(.horizontal, 30)
                    
                    if isEditing {
                                    // 편집 모드일 때 편집 가능한 필드 사용
                                    TextField("제목", text: $editedTitle)
                                        .font(.largeTitle)
                                        .padding(.horizontal, 30)
                                    TextField("코멘트", text: $editedComment)
                                        .padding(.horizontal, 30)
                                } else {
                                    // 편집 모드가 아닐 때 일반 텍스트 표시
                                    Text(editedTitle)
                                        .font(.largeTitle)
                                        .padding(.horizontal, 30)
                                    Text(editedComment)
                                        .padding(.horizontal, 30)
                                }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(tags, id: \.self) { tag in
                                TagView(tag: tag)
                            }
                        }
                        
                    }.padding(.horizontal, 30)

                    Text("메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터메타데이터")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 30)
                }
            }
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
