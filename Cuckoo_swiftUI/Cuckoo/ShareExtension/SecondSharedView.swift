//
//  SecondSharedView.swift
//  ShareExtension
//
//  Created by 유철민 on 12/18/23.
//

import Foundation
import SwiftUI
import SwiftSoup
import CoreData

struct SecondSharedView: View {
    
    @Binding var onClose: () -> Void // 창을 닫기 위해서 있음
    @Binding var newMemo: MemoEntity?
    
    @State private var registrationCompleted: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("메모 등록 완료!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))

            VStack {
                if let _memo = newMemo {
                    MainContainerView(
                        memo: _memo,
                        title: _memo.title,
                        comment: _memo.comment,
                        url: _memo.url,
                        thumbURL: _memo.thumbURL,
                        isPinned: _memo.isPinned,
                        created_at: _memo.created_at
                    )
                    .frame(maxHeight: 100)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 30)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
            }

            HStack(spacing: 30) {
                Spacer()

                Button("확인") {
                    onClose()
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 50) // Set a fixed size for the button
                .background(Color.cuckooViolet)
                .cornerRadius(10)

                Button("앱에서 보기") {
                    // Handle the action for "앱에서 보기"
                    // TODO : "http://Cuckoo/a" 로 연결 , 단, share extension이기 때문에 UIApplication.shared은 쓰지 못한다.
                }
                .foregroundColor(.white)
                .padding()
                .frame(width: 150, height: 50) // Set the same fixed size for the button
                .background(Color.cuckooPurple)
                .cornerRadius(10)

                Spacer()
            }
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity)

            Spacer()
        }
        .padding(20)
    }
}
