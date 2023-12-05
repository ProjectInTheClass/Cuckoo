//
//  MemoTag.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/05.
//

import Foundation

struct MemoTag : Identifiable{
    var memoId: Int
        var tagId: Int
    // Identifiable 프로토콜을 준수하기 위한 id 프로퍼티
        var id: String {
            "\(memoId)-\(tagId)"
        }
        // This class seems to be a junction table for a many-to-many relationship between Memos and Tags
        // ... include other properties as needed
}
