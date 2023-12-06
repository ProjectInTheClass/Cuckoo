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

let dummyMemoTags = [
    MemoTag(memoId: 1, tagId: 1),
    MemoTag(memoId: 1, tagId: 2),
    MemoTag(memoId: 1, tagId: 3),
    MemoTag(memoId: 1, tagId: 4),
    MemoTag(memoId: 1, tagId: 5),
    MemoTag(memoId: 2, tagId: 6),
    MemoTag(memoId: 2, tagId: 7),
    MemoTag(memoId: 2, tagId: 8),
    MemoTag(memoId: 2, tagId: 9),
    MemoTag(memoId: 2, tagId: 10),
    MemoTag(memoId: 3, tagId: 1),
    MemoTag(memoId: 3, tagId: 3),
    MemoTag(memoId: 4, tagId: 4),
    MemoTag(memoId: 4, tagId: 2),
    MemoTag(memoId: 5, tagId: 5),
    MemoTag(memoId: 5, tagId: 10)
]

