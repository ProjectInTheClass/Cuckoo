//
//  SettingTagViewModel.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/08.
//

import Foundation

import Foundation

class SettingTagViewModel: ObservableObject {
    @Published var tags: [Tag]

    init(tags: [Tag] = dummyTags) {
        self.tags = tags
    }

    func addTag(name: String, color: String) {
        let newTag = Tag(id: tags.count + 1, name: name, color: color, memoCount: 0)
        tags.append(newTag)
    }
}
