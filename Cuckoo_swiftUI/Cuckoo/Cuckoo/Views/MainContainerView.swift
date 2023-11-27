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
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size:14, weight:.bold))
                    .frame(maxWidth: 133, alignment: .leading)
                Text(detail)
                    .font(.system(size:12, weight: .regular))
                    .frame(maxWidth: 133,maxHeight: 60, alignment: .topLeading)
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
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
            Image(systemName: imageName)
                .resizable()
                .font(.title)
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 94)
        }
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: 330, height:104)
        Divider()
            .background(Color.black)
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

