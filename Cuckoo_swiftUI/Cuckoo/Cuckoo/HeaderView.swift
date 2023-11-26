//
//  HeaderView.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/26.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            // Navigation back button
            Button(action: {
                // Handle back button action
            }) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 15, height: 24)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 0))
            }
            Spacer() // Spacer to balance the alignment
        }
    }
}

#Preview {
    HeaderView()
}
