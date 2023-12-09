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
    var thumbURL: URL?
    var notificationCycle: Int
    var notificationPreset: Int
    var notificationCount: Int
    var isPinned: Bool
    var createdAt: Date
    var updatedAt: Date

    init(id: Int,
         userId: Int,
         title: String,
         comment: String,
         url: URL? = nil,
         thumbURL: URL? = nil,
         notificationCycle: Int,
         notificationPreset: Int,
         notificationCount: Int? = 0,
         isPinned: Bool = false,
         createdAt: Date? = nil,
         updatedAt: Date? = nil) {
        
        self.id = id
        self.userId = userId
        self.title = title
        self.comment = comment
        self.url = url
        self.thumbURL = thumbURL
        self.notificationCycle = notificationCycle
        self.notificationPreset = notificationPreset
        self.notificationCount = notificationCount!
        self.isPinned = isPinned
        self.createdAt = createdAt ?? Date()
        self.updatedAt = updatedAt ?? Date()
    }
}

// Codable

struct CreateMemoRequest: Codable {
    let type, identifier: String
    let isPinned: Bool
    let title, comment: String
    let url: String
    let notiCycle, notiPreset, notiCount: Int

    enum CodingKeys: String, CodingKey {
        case type, identifier, isPinned, title, comment, url
        case notiCycle = "noti_cycle"
        case notiPreset = "noti_preset"
        case notiCount = "noti_count"
    }
}

struct LoadMemoResponseElement: Codable {
    let id, userID: Int
    let title, comment: String
    let url: String
    let thumbURL: String
    let notiCycle, notiPreset, notiCount, isPinned: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, comment, url, thumbURL
        case notiCycle = "noti_cycle"
        case notiPreset = "noti_preset"
        case notiCount = "noti_count"
        case isPinned = "is_pinned"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias LoadMemoResponse = [LoadMemoResponseElement]
