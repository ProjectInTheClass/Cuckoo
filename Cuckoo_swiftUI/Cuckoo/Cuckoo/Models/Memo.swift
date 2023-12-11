//
//  MemoModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation


struct Memo: Codable {
    var id, userID: Int
    var title, comment: String
    var url: String
    var thumbURL: String
    var notiCycle, notiPreset, notiCount, isPinned: Int
    var createdAt, updatedAt: String
//    let tag: [Tag]

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
//        case tag
    }
}

// MARK: - Tag
//struct Tag: Codable {
//    let id: Int
//    let name, color: String
//    let memoCount: Int
//}

typealias MemoList = [Memo]
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
