//
//  SecondSharedView.swift
//  ShareExtension
//
//  Created by 유철민 on 12/18/23.
//

import Foundation
import SwiftUI
import SwiftSoup

struct SecondSharedView: View {
    
    @State private var registrationCompleted = false
    @Binding var onClose: () -> Void // 창을 닫기 위해서 있음
    @Binding var newURL : String
    @ObservedObject var mvm = MemoViewModel.shared
    
    var body: some View {
    
        
        VStack{
            
            let memo = mvm.getMostRecentlyCreatedMemo()
            
            Text("메모 등록 완료!")
            
            VStack{
                BarDivider()
                
                MainContainerView(memo: memo!, title: memo!.title, comment: memo!.comment, url: memo!.url, thumbURL: memo!.thumbURL, isPinned: memo!.isPinned, created_at: memo!.created_at)
                
                BarDivider()
            }
            
            HStack{
                Button("확인"){
                    onClose()
                }
                
                Button("앱에서 보기"){
                    var a = Link("Open in Browser", destination: URL(string : "Cuckoo://a")!)
                }
            }
        }
    }
}
