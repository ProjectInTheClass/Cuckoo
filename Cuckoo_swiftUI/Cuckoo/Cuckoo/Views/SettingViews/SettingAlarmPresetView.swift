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
    
    @State private var selectedReminderPeriod = 1
    @State private var isReminderPeriodPopoverPresented = false
    
    @State private var isMultiplierPopoverPresented = false
    @State private var selectedMultiplier = 1
    
    @State private var isDeleteConfirmationPresented = false
    
    
    
    var body: some View {
        VStack {
            HeaderView(title: "알람 주기 / 프리셋 설정")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(spacing: 20) {
                    AddAlarmTermHeaderView()
                    AddAlarmTermBodyView(
                        selectedReminderPeriod: $selectedReminderPeriod, selectedMultiplier: $selectedMultiplier
                    )
                    AddAlarmPresetView()
                }.padding(.horizontal, 30)
            }.padding(.vertical, 20)
            
            
        }.navigationBarBackButtonHidden(true)
    }
    
    
}

struct SettingAlarmPresetView_Previews: PreviewProvider {
    static var previews: some View {
        //        SettingsView_myInfo()
        SettingAlarmPresetView()
    }
}
