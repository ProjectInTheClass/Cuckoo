//
//  TagModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation

struct Tag:Identifiable{
    var id: Int
    var name: String
    var color: String
    var memoCount: Int
}

let dummyTags = [
    Tag(id: 1, name: "태그1", color: "#FF5733", memoCount: 2),
    Tag(id: 2, name: "태그2", color: "#33FF57", memoCount: 2)
]

