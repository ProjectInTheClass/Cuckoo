//
//  MainContainerView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

//pinpoint
struct RotatedImageView: View {
    var body: some View {
        Image(systemName: "pin.fill")
            .foregroundColor(Color.black)
            .rotationEffect(Angle(degrees: 45))
    }
}

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
                    if(memo.isPinned){
                        HStack(spacing: 3){
                            RotatedImageView()
                            Text(memo.title)
                                .font(.system(size:18, weight:.bold))
                                .foregroundColor(Color.black)
                                .lineLimit(1) // 한 줄로 제한
                                .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                        }
                    }else{
                        Text(memo.title)
                            .font(.system(size:18, weight:.bold))
                            .foregroundColor(Color.black)
                            .lineLimit(1) // 한 줄로 제한
                            .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    }

                    
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
                
                MemoThumbnailImageView(memo: memo)
                
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct MemoThumbnailImageView: View {
    var memo: Memo
    
    var width: CGFloat = 140
    var height: CGFloat = 94

    var body: some View {
        ZStack {
            if let thumbURL = memo.thumbURL {
                AsyncImage(url: thumbURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                } placeholder: {
                    Image("DefaultPreview")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                }
                .background(Color.cardBackground)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.defaultPure, lineWidth: 1)
                        .opacity(0.5)
                )

                // 링크 추가
                if let linkURL = memo.url {
                    Link(destination: linkURL) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: width, height: height)
                    }
                }
            } else {
                Image("DefaultPreview")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
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

