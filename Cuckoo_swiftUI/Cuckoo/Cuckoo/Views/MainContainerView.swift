//
//  MainContainerView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

struct MainContainerView: View {
    let title: String
    let detail: String
    let tag: String
    let timeAgo: String
    let memoURL: String
    let thumbURL: String

    @State var image: Image?
        
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                // TODO: [동우] Color 일괄 변경 필요
                // TODO: [동우] width 값 fix값 뺄 수 있는지 확인
                Text(title)
                    .font(.system(size:16, weight:.bold))
                    .frame(alignment: .leading)
                    .lineLimit(1) // 한 줄로 제한
                    .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                
                // TODO: [동우] Color 일괄 변경 필요
                Text(detail)
                    .font(.system(size:10, weight: .regular))
                    .frame(maxWidth: 160, maxHeight: 60, alignment: .topLeading)
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                
                
                Spacer()
                
                // TODO: [동우] Color 일괄 변경 필요
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing:0){
                        Text("\(tag) · \(timeAgo)")
                            .font(.system(size: 8, weight:.light))
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    }
                    if memoURL != "" {
                        Text(memoURL)
                            .font(.system(size: 8, weight:.light))
                            .underline()
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                            .frame(maxWidth:160, alignment:.leading)
                            .lineLimit(1) // 한 줄로 제한
                            .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    }
                }

                
            }
            Spacer()
            // TODO: [동우] Default image 넣게끔 (Figma 참고)
            VStack {
                
                if thumbURL != "" {
                    AsyncImage(url: URL(string: thumbURL)) { image in
                        image
                            .resizable()
                            .scaledToFill() // 또는 scaledToFill() 사용
                            .frame(height: 94)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 140, height: 94)
                    .background(Color.cardBackground)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.defaultPure, lineWidth: 1)
                            .opacity(0.5)
                    )

                    
                } else {
                    Image("DefaultPreview")
                        .resizable()
                        .frame(width: 140, height: 94)
                        .scaledToFill() // 또는 scaledToFill() 사용
                        .background(Color.cardBackground)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.defaultPure, lineWidth: 1)
                                .opacity(0.5)
                        )

                }
                
                
            }
        }
        .frame(maxWidth: .infinity)
        Divider()
    }
}

struct Item {
    let id: Int
    let title: String
    let detail: String
    let tag: String
    let timeAgo: String
    let memoURL: String
    let thumbURL: String
}

