//
//  MainContainerView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI
import CoreData

//pinpoint
struct RotatedImageView: View {
    var body: some View {
        Image(systemName: "pin.fill")
            .foregroundColor(Color.black)
            .rotationEffect(Angle(degrees: 45))
    }
}

struct MainContainerView: View {
    @ObservedObject var memoViewModel = MemoViewModel.shared
    var tag: String = "2 days ago"
    var timeAgo: String = "전체"
    
    var title: String
    var comment: String
    var url: URL?
    var thumbURL : URL?
    var isPinned: Bool
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    if(isPinned){
                        HStack(spacing: 3){
                            RotatedImageView()
                            Text(title)
                                .font(.system(size:18, weight:.bold))
                                .foregroundColor(Color.black)
                                .lineLimit(1) // 한 줄로 제한
                                .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                        }
                    }else{
                        Text(title)
                            .font(.system(size:18, weight:.bold))
                            .foregroundColor(Color.black)
                            .lineLimit(1) // 한 줄로 제한
                            .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    }

                    
                    Text(comment)
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
                    if let url = url {
                        Text(url.absoluteString)
                            .font(.system(size: 10, weight:.light))
                            .underline()
                            .foregroundColor(Color.cuckooNormalGray)
                            .frame(maxWidth:160, alignment:.leading)
                            .lineLimit(1) // 한 줄로 제한
                            .truncationMode(.tail) // 끝 부분에서 잘리도록 설정
                    }
                }
            } // VStack
            Spacer()
            
            VStack {
                
                MemoThumbnailImageView(thumbURL: thumbURL, url: url)
                
            }
        } // HStack
        .frame(maxWidth: .infinity)
    }
}

struct MemoThumbnailImageView: View {
//    var memo: MemoEntity
    var width: CGFloat = 140
    var height: CGFloat = 94
    var thumbURL: URL?
    var url: URL?

    
    var body: some View {
        ZStack {
            if let thumbURL = thumbURL {
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
                if let url = url {
                    Link(destination: url) {
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
