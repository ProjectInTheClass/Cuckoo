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
    
    @ObservedObject var mvm = MemoViewModel.shared
    
    @Binding var onClose: () -> Void // 창을 닫기 위해서 있음
    @Binding var image : UIImage
    @Binding var selectedTags: Set<TypeBubble>
    @Binding var memoTitle: String //MemoTitleFormView로부터
    @Binding var memoContent: String
    
    @State private var registrationCompleted = false
    var linkURL : String?
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading){
                //header
                HStack {
                    Spacer()
                    Text("메모 등록")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.80))
                    Spacer()
                }.frame(height: 60)
                    .frame(maxWidth: .infinity)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .padding()
                
                //            loadMadeMemoContainer()
                
                MainContainerView(
                    title: memoTitle,
                    detail: memoContent,
                    tag: selectedTags.isEmpty ? "" : "태그 : " + (String(selectedTags.first!.title) + (selectedTags.count > 1 ? " 외 \(selectedTags.count - 1)개 / " : " / ")),
                    timeAgo: "방금",//TODO : 방금이라고 표시할 기준도 마련
                    memoURL: linkURL!,
                    image: image                )
                .padding()
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .padding()
                
                HStack {
                    
                    Spacer()
                    
                    Button("앱에서 확인") {
                        //url scheme 통해서 연결
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40))
                    .background(.thickMaterial)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    
                    
                    Spacer()
                    Button("확인") {
                        onClose()
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 50, bottom: 20, trailing: 50))
                    .background(Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5) // Optional: Add a border
            )
            .background(Color.white)
        }
    }
    
}
