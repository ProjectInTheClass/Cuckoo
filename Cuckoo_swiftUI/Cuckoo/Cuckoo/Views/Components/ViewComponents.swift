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


/*
    * 이하는 Alarm Preset 관련 Component
*/


struct presetButton : Hashable{// Hash=> 기억해두자
    var emoji : String
    var alarmName : String
    var time : String
    
    init(emoji: String, alarmName: String, time: String) {
        self.emoji = emoji
        self.alarmName = alarmName
        self.time = time
    }
    
    // Implementing the Hashable protocol => 기억해두자
    func hash(into hasher: inout Hasher) {
        hasher.combine(emoji)
        hasher.combine(alarmName)
        hasher.combine(time)
    }
}

// Custom button style for Notification Buttons => 이렇게 따로 만들 수 있다.
struct NotificationButtonStyle: ButtonStyle {
    let selected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(selected ? Color(red: 109 / 255, green: 37 / 255, blue: 224 / 255) : Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255))
            .foregroundColor(selected ? .white : .black)
            .cornerRadius(10)
    }
}
