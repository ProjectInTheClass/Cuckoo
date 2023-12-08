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
