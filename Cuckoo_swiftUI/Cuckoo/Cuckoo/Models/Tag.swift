//
//  TagModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//
import SwiftUI
import Foundation

struct Tag:Identifiable{
    var id: Int
    var name: String
    var color: String
    var memoCount: Int
}

let dummyTags = [
    Tag(id: 1, name: "태그1", color: Color.cuckooRed.toHex() ?? "#FF0000", memoCount: 2),
    Tag(id: 2, name: "태그2", color: Color.cuckooPurple.toHex() ?? "#800080", memoCount: 2),
    Tag(id: 3, name: "태그3", color: Color.cuckooViolet.toHex() ?? "#EE82EE", memoCount: 3),
    Tag(id: 4, name: "태그4", color: Color.cuckooBlue.toHex() ?? "#0000FF", memoCount: 1),
    Tag(id: 5, name: "태그5", color: Color.cuckooGreen.toHex() ?? "#008000", memoCount: 4),
    Tag(id: 6, name: "태그6", color: Color.cuckooYellow.toHex() ?? "#FFFF00", memoCount: 5),
    Tag(id: 7, name: "태그7", color: Color.cuckooCarrot.toHex() ?? "#FFA500", memoCount: 1),
    Tag(id: 8, name: "태그8", color: Color.cuckooBrown.toHex() ?? "#A52A2A", memoCount: 3),
    Tag(id: 9, name: "태그9", color: Color.cuckooDeepGray.toHex() ?? "#A9A9A9", memoCount: 2),
    Tag(id: 10, name: "태그10", color: Color.cuckooLightGray.toHex() ?? "#D3D3D3", memoCount: 4)
]



