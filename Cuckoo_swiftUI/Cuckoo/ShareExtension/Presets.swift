//
//  preset.swift
//  ShareExtension
//
//  Created by 유철민 on 12/7/23.
//

import Foundation
import SwiftUI

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

var presetButtonList: [presetButton] = [
        presetButton(emoji: "🔔", alarmName: "기상", time: "07:00 AM"),
        presetButton(emoji: "🔔", alarmName: "점심밥", time: "12:00 PM"),
        presetButton(emoji: "🔔", alarmName: "저녁식사", time: "06:00 PM"),
        presetButton(emoji: "🔔", alarmName: "운동", time: "05:00 PM"),
        presetButton(emoji: "🔔", alarmName: "독서", time: "08:00 PM"),
        presetButton(emoji: "🔔", alarmName: "취침 전", time: "10:00 PM"),
        presetButton(emoji: "🔔", alarmName: "회의", time: "02:30 PM"),
        presetButton(emoji: "🔔", alarmName: "수업 시작", time: "09:00 AM")
]
