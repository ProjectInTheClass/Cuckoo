//
//  AlarmPreset.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/05.
//

import Foundation

struct AlarmPreset : Identifiable{
    var id: Int
    var preset_name: String
    var preset_icon: String
    var preset_time: String
    var created_at: Date
    
    init(id: Int? = 1, preset_name: String, preset_icon: String, preset_time: String, created_at: Date? = Date()) {
        self.id = id ?? 1
        self.preset_icon = preset_icon
        self.preset_name = preset_name
        self.preset_time = preset_time
        
        self.created_at = created_at ?? Date()
    }
}

struct CreateAlarmPresetRequest: Codable {
    let type, identifier, name, icon: String
    let alarmTime: String

    enum CodingKeys: String, CodingKey {
        case type, identifier, name, icon
        case alarmTime = "alarm_time"
    }
}
