////
////  MemoTitleFormView.swift
////  ShareExtension
////
////  Created by 유철민 on 12/6/23.
////
//
//import SwiftUI
//
//struct MemoTitleFormView: View {
//    @State public var memoTitle: String = "" // 사용자가 입력할 제목을 저장할 상태 변수입니다.
//    private let maxCharacterLimit = 30 //TODO : db varchar이라면 limit을 어떻게 잡을지 반영
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            CardTitleText(title: "제목")
//            CardContent {
//                HStack{
//                    TextField("메모 제목을 작성해주세요.", text: $memoTitle, axis: .vertical)
//                        .font(.system(size: 12, weight: .medium))
//                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
//                        .multilineTextAlignment(.leading)
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, alignment: .center) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
//                        .cornerRadius(10) // 코너 반경 설정
//                        .onChange(of: memoTitle) { newValue in
//                            if newValue.count > maxCharacterLimit {
//                                memoTitle = String(newValue.prefix(maxCharacterLimit))
//                            }
//                        }
//            
//                    Text("\(memoTitle.count) / \(maxCharacterLimit)")
//                        .font(.system(size: 12))
//                        .foregroundColor(memoTitle.count == maxCharacterLimit ? .pink : .gray)
//                        .cornerRadius(10)
//                        .padding(.trailing, 10)
//                        
//    
//                }
//                .background(.black.opacity(0.1))
//                .cornerRadius(10)
//                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 30, alignment: .center)
//                
//            }
//        }
//    }
//}
