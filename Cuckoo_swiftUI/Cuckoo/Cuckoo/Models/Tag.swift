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
    Tag(id: 2, name: "태그2", color: "#33FF57", memoCount: 2),
    Tag(id: 3, name: "태그3", color: "#3357FF", memoCount: 3),
    Tag(id: 4, name: "태그4", color: "#FF33F7", memoCount: 1),
    Tag(id: 5, name: "태그5", color: "#57FF33", memoCount: 4),
    Tag(id: 6, name: "태그6", color: "#FF8333", memoCount: 5),
    Tag(id: 7, name: "태그7", color: "#337FFF", memoCount: 1),
    Tag(id: 8, name: "태그8", color: "#FF3374", memoCount: 3),
    Tag(id: 9, name: "태그9", color: "#33FF7F", memoCount: 2),
    Tag(id: 10, name: "태그10", color: "#7F33FF", memoCount: 4)
]


