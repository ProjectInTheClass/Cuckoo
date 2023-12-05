//
//  MemoModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation

struct Memo: Identifiable {
    var id: Int
    var userId: Int
    var title: String
    var comment: String
    var url: URL?
    var thumbURL : URL?
    var notificationCycle: Int // Assuming it's an integer
    var notificationTime: [String] // Assuming it's a list of dates
    var notificationStatus: String
    var notificationCount: Int
    var isPinned: Bool
    var createdAt: Date
    var updatedAt: Date
    var remainingNotificationTime: Date // Assuming it's a single date
    
}


let dummyMemo = Memo(
    id: 1, // id 추가 (예시로 1을 사용)
    userId: 1, // userId 추가 (예시로 1을 사용)
    title: "Sample Memo",
    comment:"This is a sample memo.",
    url: URL(string: "https://www.example.com"),
    notificationCycle: 7, // 예시 값
    notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
    notificationStatus: "Active", // 예시 상태
    notificationCount: 3, // 예시 횟수
    isPinned: false, // 예시 고정 상태
    createdAt: Date(),
    updatedAt: Date(),
    remainingNotificationTime: Date() // 예시 남은 알림 시간
)
