//
//  componentsView.swift
//  ShareExtension
//
//  Created by 유철민 on 2023/12/01.
//

import Foundation
import SwiftUI

//struct MemoTypeFormView: View {
//    @State private var tagList : [TypeBubble]
//    
//    init(tagList : [TypeBubble]){
//        self.tagList = tagList
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            CardTitleText(title: "메모 타입")
//            CardContent {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(tagList, id: \.self) { typeBubble in
//                            Button(action: {
//                                // Handle button tap, you can toggle the selected state here
//                                if selectedTags.contains(typeBubble) {
//                                    typeBubble.selected = false
//                                    selectedTags.remove(typeBubble)
//                                
//                                } else {
//                                    selectedTags.insert(typeBubble)
//                                }
//                            }) {
//                                
//                            }
//                            .buttonStyle(TypeBubbleButtonStyle(selected: typeBubble.selected, hexCode: typeBubble.hexCode))
//                        }
//                    }
//                }
//            }
//        }
//    }
//}


//struct MemoURLView: View {
//    var linkURL : String
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            CardTitleText(title: "Link")
//            CardContent {
//                HStack {
//                    Text(linkURL)
//                        .font(.system(size: 16, weight: .medium))
//                        .foregroundColor(.black)
//                }
//            }
//        }
//    }
//}


