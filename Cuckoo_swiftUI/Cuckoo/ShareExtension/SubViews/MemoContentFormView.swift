//
//  MemoContentFormView.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI

//struct MemoContentFormView: View {
//    @State public var memoContent: String = "" // 사용자가 입력할 내용을 저장할 상태 변수입니다.
//    private let maxCharacterLimit = 250
//
//    init() {
//        UITextView.appearance().backgroundColor = .clear
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            CardTitleText(title: "메모 내용")
//            CardContent {
//                // TextEditor의 스크롤 가능한 영역 설정
//                VStack(alignment: .leading, spacing: 0){
//                    TextField("메모 디테일한 내용을 작성해주세요.", text: $memoContent, axis: .vertical)
//                        .font(.system(size: 12, weight: .medium))
//                        .padding(10)
//                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 120, alignment: .top) // 가로길이 고정을 위해 최소 너비를 0, 최대 너비를 무한으로 설정합니다.
//                        .background(.black.opacity(0.1)) // 배경색 설정
//                        .cornerRadius(10) // 코너 반경 설정
//                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
//                        .onChange(of: memoContent) { newValue in
//                            if newValue.count > maxCharacterLimit {
//                                memoContent = String(newValue.prefix(maxCharacterLimit))
//                            }
//                        }
//                    
//                    HStack {
//                        Spacer()
//                        Text("\(memoContent.count) / \(maxCharacterLimit)")
//                            .font(.system(size: 12))
//                            .foregroundColor(memoContent.count == maxCharacterLimit ? .pink : .gray)
//                            .padding(.top, -23)
//                            .padding(.trailing, 15)
//                    }
//                    
//                }
//            }
//            Spacer()
//        }
//    }
//}
//
//struct MemoAlarmIntervalFormView: View {
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            VStack(alignment: .leading, spacing: 3) {
//                HStack {
//                    Text("알람 주기 설정")
//                        .font(.system(size: 16, weight: .medium))
//                        .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
//                    
//                    Spacer()
//                }
//                Text("푸시 알림으로 반복해서 리마인드할 주기!")
//                  .font(.system(size: 12, weight: .medium))
//                  .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
//            }
//            CardContent {
//                
//            }
//        }
//    }
//}
//
//
