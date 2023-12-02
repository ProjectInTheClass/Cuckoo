//
//  MemoModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation

struct Memo: Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var tags: [String]
    var link: String
    var lastEdited: Date
}
