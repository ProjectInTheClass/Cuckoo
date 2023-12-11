//
//  SettingsView_myAlertPeriod.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/11/21.
//

import Foundation
import SwiftUI

struct SettingAlarmPresetView: View {
    
    @State private var isAddPopoverPresented = false
    @State private var newEmoji = ""
    @State private var newAlarmName = ""
    @State private var newTime = ""
    @State private var selectedHourIndex = 12
    @State private var selectedMinuteIndex = 0
    @State private var selectedPresets: Set<presetButton> = []
    
    @State private var selectedReminderPeriod = "1일"
    @State private var isReminderPeriodPopoverPresented = false
    
    @State private var isMultiplierPopoverPresented = false
    @State private var selectedMultiplier = 2
    
    @State private var isDeleteConfirmationPresented = false
    
    @EnvironmentObject public var viewModel : AlarmPresetViewModel
    
    
    var body: some View {
        VStack {
            
            HeaderView(title: "알람 주기 / 프리셋 설정")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(spacing: 20) {
                    AddAlarmTermHeaderView()
                    AddAlarmTermBodyView()
                    AddAlarmPresetView()
                        .environmentObject(viewModel)
                }.padding(.horizontal, 30)
            }.padding(.vertical, 20)
            
            
        }.navigationBarBackButtonHidden(true)
    }
    
//    func addNewPreset() {
//        let hour = selectedHourIndex
//        let minute = selectedMinuteIndex
//        let period = hour < 12 ? "AM" : "PM"
//        let formattedTime = String(format: "%02d:%02d %@", hour % 12, minute, period)
//        
//        let newPreset = presetButton(emoji: newEmoji, alarmName: newAlarmName, time: formattedTime, preset_id: 1)
//        presetButtonList.append(newPreset)
//        
//        //시간 순대로 나오도록
//        presetButtonList.sort { $0.time < $1.time }
//        
//        //다음을 위해 초기화
//        newEmoji = ""
//        newAlarmName = ""
//        selectedHourIndex = 12
//        selectedMinuteIndex = 0
//    }
//    
//    func deleteSelectedPresets() {
//        presetButtonList.removeAll { selectedPresets.contains($0) }
//        selectedPresets.removeAll()
//    }
//    
//    func showAlert(title: String, message: String) {
//        // Show an alert with the given title and message
//    }
    
}

struct SettingAlarmPresetView_Previews: PreviewProvider {
    static var previews: some View {
        //        SettingsView_myInfo()
        SettingAlarmPresetView()
    }
}
