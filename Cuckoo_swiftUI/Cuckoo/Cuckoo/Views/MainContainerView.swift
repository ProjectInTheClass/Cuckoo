//
//  MainContainerView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

struct MainContainerView: View {
    
    var memo: Memo
    
    var tag: String
    var timeAgo: String
    
    init(memo: Memo) {
        self.memo = memo
        self.timeAgo = "2 days ago" // TODO : 현재 Date랑 차이를 통해, now(5분미만), n minutes ago,  n hour(s) ago, day(s) ago, week(s) ago 중 하나로 나타내야함.
        self.tag = "전체" // TODO : MemoTag에서, memo_id 기준으로 검색 후에 나오는 tag id중 가장 처음거로
    }
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(memo.title)
                        .font(.system(size:18, weight:.bold))
                        .foregroundColor(Color.black)
                        .lineLimit(1) // 한 줄로 제한
                        .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    
                    Text(memo.comment)
                        .font(.system(size:12, weight: .regular))
                        .foregroundColor(Color.cuckooNormalGray)
                        .frame(maxWidth: 160, alignment: .leading)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 0){
                    HStack(spacing:0){
                        Text("\(tag) · \(timeAgo)")
                            .font(.system(size: 10, weight:.light))
                            .foregroundColor(Color.cuckooNormalGray)
                    }
                    if memo.url != nil {
                        Text(memo.url?.absoluteString ?? "")
                            .font(.system(size: 10, weight:.light))
                            .underline()
                            .foregroundColor(Color.cuckooNormalGray)
                            .frame(maxWidth:160, alignment:.leading)
                            .lineLimit(1) // 한 줄로 제한
                            .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    }
                }

                
            }
            Spacer()
            
            VStack {
                
                if memo.thumbURL != nil {
                    AsyncImage(url: memo.thumbURL) { image in
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

