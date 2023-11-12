//
//  MemoDetailView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/12.
//

import SwiftUI

struct MemoDetailView: View {
    let tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5"]

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

                Button(action: {
                }) {
                    Image(systemName: "pencil")
                }
                .foregroundColor(.gray)
                
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
                    
                    Text("Title")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 30)
                    
                    Text("코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트코멘트")
                        .padding(.horizontal, 30)
                    
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
