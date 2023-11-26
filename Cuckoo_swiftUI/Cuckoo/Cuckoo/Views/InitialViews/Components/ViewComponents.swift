//
//  ViewComponents.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import SwiftUI
import Combine


struct HeaderView: View {
    var title: String;
    
    var body: some View {
        VStack {
                Spacer()
                Text(title)
                .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0).opacity(0.80))
        }
    }
}

struct BarDivider: View {
  var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(width: .infinity, height: 0.2)
      .overlay(
        Rectangle()
          .stroke(
            Color(red: 0, green: 0, blue: 0).opacity(0.10), lineWidth: 0.50
          )
      );
  }
}


struct ConfirmFixedButton: View {
    var confirmMessage: String
    
    var body: some View {
        VStack {
                Text(confirmMessage)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(.purple)
        .cornerRadius(15)
        .padding(.horizontal, 30)

    }
}
