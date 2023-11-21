//
//  MainContainerView.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/11/07.
//

import SwiftUI

struct MainContainerView: View {
    let title: String
    let details: [String]
    let imageName: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                ForEach(details, id: \.self) { detail in
                    Text(detail)
                        .font(.subheadline)
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
    let details: [String]
    let imageName: String
}
