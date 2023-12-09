//
//  MemoViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation

class MemoViewModel: ObservableObject {
    @Published var memos: [Memo]
    
    init() {
        self.memos = [];
    }
    
    
    private func requestUserMemos(uuid: String) -> [Memo] {
        // 서버에 GET 요청 보내고 응답 받기 : Alamofire로 구현 필요
        // 실제 앱에서는 HTTP 요청을 처리하는 로직이 필요함
        // 여기에서는 예시 응답을 반환함 (Dummy)
        return items
    }
    
    func browseMemosFromServer(uuid: String!) {
        /// TODO :: User의 UUID를 받아서, 서버에 요청 보내고 memos 배열 초기화
        let response: [Memo] = requestUserMemos(uuid: uuid)
        
        /// GET /memo
        /// queryString : type=uuid&identifier={uuid}
        
        self.memos = response
    }
    
    func getMemoList() -> [Memo] {
        return self.memos
    }
    
    func addMemo(
        uuid: String!,
        title: String,
        comment: String,
        url: URL? = URL(string:""),
        thumbURL: URL? = URL(string: ""),
        noti_cycle: Int,
        noti_preset: Int,
        isPinned: Bool? = false
    ) {
        /// TODO :: User의 UUID와 target의 MemoItem 객체를 받아서 처리
        ///     MemoItem은 내가 따로 정의한 거임 -> 이런식으로 원하는 값만 처리하기 위해서 Struct를 정의해도 됨 (이런게 Serialize.)
        ///     아니면 targetMemo 지우고 user_uuid, title, comment, noti_cycle, noti_preset, isPinned 를 직접 받아서 넣어도 됨.

        /// POST /memo
        /// body : type, identifier, title, comment, noti_cycle, noti_preset, isPinned, url, noti_count
        /// - type은 "uuid" 고정, identifier에는 uuid 값을 넣으면 됨. (doc 참고)
        /// - url의 경우 입력 안했다면 빈 문자열 (URL 형식이 아니면 받으면 안됨)

        /// 성공적으로 추가했다면, 응답에서 id을 반환받아서, Memo 객체를 새로 정의해서 memos 배열에 넣고
        /// 실패했다면 alert 등을 띄우기
    }
    
    func editMemo(
        uuid: String!,
        memo_id: Int,
        title: String?,
        comment: String?,
        url: URL? = URL(string:""),
        thumbURL: URL? = URL(string: ""),
        noti_cycle: Int?,
        noti_preset: Int?
    ) {
        /// TODO :: User의 UUID와 target의 MemoItem 객체를 받아서 처리
        ///     MemoItem은 내가 따로 정의한 거임 -> 이런식으로 원하는 값만 처리하기 위해서 Struct를 정의해도 됨 (이런게 Serialize.)

        /// PUT /memo/:memo_id
        /// queryString : type=uuid&identifier={uuid}
        /// body: 수정되는 부분만 body에 담아서 보내면 됨
        ///  ex: { title: "수정할 제목" }

        /// 성공적으로 수정했다면, 수정한 부분만 값 반영
        /// 실패했다면 alert 등을 띄우기
    }
    
    func deleteMemo(uuid: String!, memo_id: Int) {
        /// TODO :: User의 UUID와 memo_id를 받아서 삭제

        /// DELETE /memo/:memo_id
        /// queryString : type=uuid&identifier={uuid}

        /// 성공적으로 삭제했다면, 리스트에서 메모 삭제
        /// 실패했다면 alert 등을 띄우기
    }
}
