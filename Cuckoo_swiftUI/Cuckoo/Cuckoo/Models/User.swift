//
//  UserModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation

struct User:Identifiable{
    var id: Int // Assuming id is an integer
        var username: String
        var code: String // Assuming code is a string
        var uuid: UUID
        var createdAt: Date
        // ... include other properties as needed
}
