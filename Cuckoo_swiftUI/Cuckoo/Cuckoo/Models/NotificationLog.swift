//
//  NotificationLog.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/05.
//

import Foundation

struct NotificationLog : Identifiable {
    var id: Int
    var userId: Int
    var memoIdList: [Int] // 관련 memo ID
    var sentAt: String // detail한 Date -> TODO :: Date() 로 바꿔야함!!!
    var sentTerm: String // "아침 시간대", "저녁 시간대" 등
}
