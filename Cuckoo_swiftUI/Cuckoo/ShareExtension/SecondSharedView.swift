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
        
        
        VStack(spacing: 20){
            
            Spacer()
            
            Text("메모 등록 완료!")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            
            VStack{
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
                }
            
            }
            
            
            HStack(spacing: 30){
                
                    Spacer()
                Button("확인"){
                    onClose()
                }
                
                
                Button("앱에서 보기"){
                    var a = Link("Open in Browser", destination: URL(string : "Cuckoo://a")!)
                }
                
                    Spacer()
            }
            
            Spacer()
        }
    }
}
