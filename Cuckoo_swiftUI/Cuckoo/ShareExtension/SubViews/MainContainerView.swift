//
//  MainContainerView.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI

// 가져와서 사용할 미리보기
struct MainContainerView: View {
    let title: String
    let detail: String
    let tag: String
    let timeAgo: String
    let memoURL: String
    //    let imageName: String
    let image: UIImage
    
    func fetchImage(url: String) -> some View {
        AsyncImage(url: URL(string: url)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 140, height: 94)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size:14, weight:.bold))
                    .frame(maxWidth: 133, alignment: .leading)
                Text(detail)
                    .font(.system(size:12, weight: .regular))
                    .frame(maxWidth: 130,maxHeight: 60, alignment: .topLeading)
                    .foregroundColor(Color(red: 0.70, green: 0.70, blue: 0.70))
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
//                VStack(alignment: .leading, spacing: 0){
//
//                }
                
                
            }
            
//                AsyncImage(url: URL(string: memoURL), content: {image in
//                    image.resizable()
//                        .font(.title)
//                        .aspectRatio(contentMode: .fill)
//                    .frame(maxWidth: 140, maxHeight: 94)}, placeholder: {
//                        ProgressView()
//                    })
//
            Image(uiImage: image)
                .resizable()
                .font(.title)
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 94)
            //            Image(systemName: imageName)
            //                .resizable()
            //                .font(.title)
            //                .aspectRatio(contentMode: .fill)
            //                .frame(width: 140, height: 94)
            
        }
        .background(Color.white)
        .cornerRadius(10)
        .frame(width: 330, height:104)
        
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
