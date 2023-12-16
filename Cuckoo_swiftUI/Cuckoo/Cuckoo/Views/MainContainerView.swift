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
    var title: String
    var comment: String
    var url: URL?
    var thumbURL : URL?
    var isPinned: Bool
    var tag: String = ""
    var timeAgo: String = ""
    
    init(memo: MemoEntity, title: String, comment: String, url: URL?, thumbURL:URL?, isPinned:Bool, created_at: Date?) {
        self.title = title
        self.comment = comment
        self.url = url
        self.thumbURL = thumbURL
        self.isPinned = isPinned
        
        
        if let tagSet = memo.memo_tag as? Set<TagEntity> {
            let tagList: [TagEntity] = Array(tagSet)
            
            self.tag = tagList[0].name
        }
        
        if let created_at = created_at {
            self.timeAgo = getTimeDelta(targetTime: created_at)
        } else {
            self.timeAgo = "오래 전"
        }
    }
    
    private func getTimeDelta(targetTime: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year], from: targetTime, to: now)

        if let year = components.year, year > 0 {
            return "\(year)년 전"
        } else if let month = components.month, month > 0 {
            return "\(month)달 전"
        } else if let day = components.day, day > 0 {
            return "\(day)일 전"
        } else if let hour = components.hour, hour > 0 {
            return "\(hour)시간 전"
        } else if let minute = components.minute, minute > 0 {
            return "\(minute)분 전"
        } else {
            return "방금 전"
        }
    }
    
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
                
                MemoThumbnailImageView(width: 140, height: 94, thumbURL: thumbURL, url: url)
                
            }
        } // HStack
        .frame(maxWidth: .infinity)
    }
}

struct MemoThumbnailImageView: View {
    var width: CGFloat // 외부에서 설정하는 값
    var height: CGFloat // 외부에서 설정하는 값
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
