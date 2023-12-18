//
//  Card.swift
//  ShareExtension
//
//  Created by 유철민 on 12/6/23.
//

import Foundation
import SwiftUI

struct CardContent<Content: View>: View {
    var child: Content
    init(@ViewBuilder content: () -> Content) {
        self.child = content()
    }
    
    var body: some View {
        child
    }
}

struct CardTitleText: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
            
            Spacer()
        }
    }
}
