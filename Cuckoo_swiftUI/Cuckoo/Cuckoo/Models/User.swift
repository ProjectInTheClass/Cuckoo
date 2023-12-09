//
//  UserModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation

struct User: Identifiable {
    var id: Int // Assuming id is an integer
    var username: String
    var uuid: UUID
    var createdAt: Date
    // ... include other properties as needed
    
    init(id: Int, username: String, uuid: UUID?, createdAt: Date?) {
        self.id = id
        self.username = username
        self.uuid = uuid! // UUID 생성
        self.createdAt = createdAt!// 현재 날짜/시간으로 초기화
    }
}
