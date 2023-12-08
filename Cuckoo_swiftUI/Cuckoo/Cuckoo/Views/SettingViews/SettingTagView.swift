//
//  SettingTagView.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/11/23.
//

import SwiftUI

struct SettingTagView: View {
    let tags = ["Tag1", "Tag2", "Tag3", "Tag4"]
    @State private var isShowingDetailView = false

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(title: "태그 관리")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            ScrollView(.horizontal, showsIndicators: false) {
                
                VStack(alignment: .leading) {
                    Text("등록 태그")
                        .font(.system(size: 25, weight: .bold))
                        HStack(spacing: 10) {
                            ForEach(tags, id: \.self) { tag in
                                SetTagView(tagName: tag)
                            }
                            Button(action: {
                                addTag()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.gray.opacity(0.4))
                            .cornerRadius(15)
                        }
                }
            }
            .padding(.horizontal,30)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    func addTag() {
        // Implement your delete memo logic here
        print("Tag added")
    }
}

struct SetTagView: View {
    let tagName: String

    var body: some View {
        Text(tagName)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(15)
    }
}

struct SettingTagHeaderView: View {
    var body: some View {
        HStack {
            Button(action: {
                // Action to go back
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            Spacer()
            Text("태그 관리")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.black.opacity(0.80))
            Spacer()
        }
    }
}

struct SettingTagView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTagView()
    }
}
