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
    let imageName: String

    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                // TODO: [동우] Color 일괄 변경 필요
                // TODO: [동우] width 값 fix값 뺄 수 있는지 확인
                Text(title)
                    .font(.system(size:16, weight:.bold))
                    .frame(maxWidth: 133, alignment: .leading)
                
                // TODO: [동우] Color 일괄 변경 필요
                Text(detail)
                    .font(.system(size:10, weight: .regular))
                    .frame(maxWidth: 133,maxHeight: 60, alignment: .topLeading)
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                
                // TODO: [동우] Color 일괄 변경 필요
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing:0){
                        Text(tag)
                            .font(.system(size: 8, weight:.light))
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                        Text(timeAgo)
                            .font(.system(size: 8, weight:.light))
                            .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                    }
                    Text(memoURL)
                        .font(.system(size: 8, weight:.light))
                        .underline()
                        .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
                        .frame(maxWidth:133, alignment:.leading)
                }

                
            }
            Spacer()
            // TODO: [동우] Default image 넣게끔 (Figma 참고)
            Image(systemName: "square.fill")
                .resizable()
                .font(.title)
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 94)
                .cornerRadius(20)
        }
        .background(Color.white)
        .frame(maxWidth: .infinity)
        Divider()
    }
}

struct Item {
    let title: String
    let detail: String
    let tag: String
    let timeAgo: String
    let memoURL: String
    let imageName: String
}

