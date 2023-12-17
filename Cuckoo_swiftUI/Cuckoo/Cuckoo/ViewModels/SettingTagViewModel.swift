//
//  SettingTagViewModel.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/08.
//

import Foundation

import Foundation

class SettingTagViewModel: ObservableObject {
//    static let shared: Setting
    @Published var tags: [TagEntity]

    init(tags: [TagEntity]) {
        self.tags = tags
    }
    
    func browseTagsFromServer(uuid: String!) {
        /// TODO :: User의 UUID를 받아서, 서버에 요청 보내고 tags 배열 초기화

        /// GET /tag
        /// queryString : type=uuid&identifier={uuid}
        
        self.tags = [];
    }
    
    func addTag(uuid: String?, name: String, color: String) {
        /// TODO :: User의 UUID와 target의 name, color 등을 받아서 처리

        /// POST /tag
        /// body : type, identifier, name, color
        /// - type은 "uuid" 고정, identifier에는 uuid 값을 넣으면 됨. (doc 참고)

        /// 성공적으로 추가했다면, 응답에서 id을 반환받아서, Tag 객체를 새로 정의해서 Tag  배열에 넣고
        /// 실패했다면 alert 등을 띄우기 (중복 문제라던가 등등)
//        let newTag = TagEntity(id: tags.count + 1, name: name, color: color, memoCount: 0)
//        tags.append(newTag)
    }
    
    func editTag(uuid: String!, tag_id: Int, name: String?, color: String?) {
        /// TODO :: User의 UUID와 target의 tag_id 를 받고,

        /// PUT /tag/:tag_id
        /// queryString : type=uuid&identifier={uuid}
        /// body: 수정되는 부분만 body에 담아서 보내면 됨
        ///  ex: { title: "수정할 제목" }

        /// 성공적으로 수정했다면, 수정한 부분만 값 반영
        /// 실패했다면 alert 등을 띄우기
    }
    
    func deleteTag(uuid: String!, tag_id: Int) {
        /// TODO :: User의 UUID와 tag_id를 받아서 삭제

        /// DELETE /tag/:tag_id
        /// queryString : type=uuid&identifier={uuid}

        /// 성공적으로 삭제했다면, 리스트에서 메모 삭제
        /// 실패했다면 alert 등을 띄우기
    }
}
