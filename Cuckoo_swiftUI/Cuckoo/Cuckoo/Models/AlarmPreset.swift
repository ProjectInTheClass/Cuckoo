//
//  AlarmPreset.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/05.
//

import Foundation

struct AlarmPreset : Identifiable{
    var id: Int
        var userId: Int
        var presetName: String
        var presetIcon: String // Assuming icon is stored as a string
        var presetValue: String // The schema is not clear on the type, assuming a string
        // ... include other properties as needed
}
