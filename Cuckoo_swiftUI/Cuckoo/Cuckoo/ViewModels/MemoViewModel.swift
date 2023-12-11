//
//  MemoViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation
import Moya

class MemoViewModel: ObservableObject {
    static let shared = MemoViewModel()//싱글톤 패턴으로 앱의 어느곳에서나 MemoViewModel.shared를 통해 같은 인스턴스에 접근할 수 있음
    @Published var memos: [Memo]
    
    
    init() {
        self.memos = [];
        
        
    }
    
    
    //    private func requestUserMemos(uuid: String) -> [Memo] {
    //        // 서버에 GET 요청 보내고 응답 받기 : Alamofire로 구현 필요
    //        // 실제 앱에서는 HTTP 요청을 처리하는 로직이 필요함
    //        // 여기에서는 예시 응답을 반환함 (Dummy)
    //        return items
    //    }
    //
    //    func browseMemosFromServer(uuid: String!) {
    //        /// TODO :: User의 UUID를 받아서, 서버에 요청 보내고 memos 배열 초기화
    //        let response: [Memo] = requestUserMemos(uuid: uuid)
    //
    //        /// GET /memo
    //        /// queryString : type=uuid&identifier={uuid}
    //
    //        self.memos = response
    //    }
    //
    //    func getMemoList() -> [Memo] {
    //        return self.memos
    //    }
    
    private func requestUserMemos(uuid: String) {
        NetworkManager.shared.memo_provider.request(.loadMemo(type: "uuid", identifier: uuid)) { result in
            switch result {
            case .success(let response):
                do {
                    let memos = try JSONDecoder().decode([Memo].self, from: response.data)
                    DispatchQueue.main.async {
                        self.memos = memos
                    }
                    print(memos)
                } catch {
                    print("Error decoding memos: \(error)")
                }
            case .failure(let error):
                print("Error loading memos: \(error)")
            }
        }
    }
    
    func browseMemosFromServer(uuid: String) {
        requestUserMemos(uuid: uuid)
    }
    
    func getMemoList() -> [Memo] {
        return self.memos
    }
    
    
    func updateMemo(uuid: String, memoId: Int, title: String?, comment: String?, url: URL?, thumbURL: URL?, notificationCycle: Int?, notificationPreset: Int?) {
        NetworkManager.shared.memo_provider.request(.updateMemo(type: "uuid", identifier: uuid, memo_id: memoId, title: title, comment: comment, url: url, thumbURL: thumbURL, noti_cycle: notificationCycle, noti_preset: notificationPreset)) { result in
            switch result {
            case .success(let response):
                do {
                    let updatedMemo = try JSONDecoder().decode(Memo.self, from: response.data)
                    DispatchQueue.main.async {
                        if let index = self.memos.firstIndex(where: { $0.id == updatedMemo.id }) {
                            self.memos[index] = updatedMemo
                        }
                    }
                } catch {
                    print("Error updating memo: \(error)")
                }
            case .failure(let error):
                print("Error updating memo: \(error)")
            }
        }
        
        //    func addMemo(
        //        uuid: String!,
        //        title: String,
        //        comment: String,
        //        url: URL? = URL(string:""),
        //        thumbURL: URL? = URL(string: ""),
        //        noti_cycle: Int,
        //        noti_preset: Int,
        //        isPinned: Bool? = false
        //    ) {
        //        /// TODO :: User의 UUID와 target의 MemoItem 객체를 받아서 처리
        //        ///     MemoItem은 내가 따로 정의한 거임 -> 이런식으로 원하는 값만 처리하기 위해서 Struct를 정의해도 됨 (이런게 Serialize.)
        //        ///     아니면 targetMemo 지우고 user_uuid, title, comment, noti_cycle, noti_preset, isPinned 를 직접 받아서 넣어도 됨.
        //
        //        /// POST /memo
        //        /// body : type, identifier, title, comment, noti_cycle, noti_preset, isPinned, url, noti_count
        //        /// - type은 "uuid" 고정, identifier에는 uuid 값을 넣으면 됨. (doc 참고)
        //        /// - url의 경우 입력 안했다면 빈 문자열 (URL 형식이 아니면 받으면 안됨)
        //
        //        /// 성공적으로 추가했다면, 응답에서 id을 반환받아서, Memo 객체를 새로 정의해서 memos 배열에 넣고
        //        /// 실패했다면 alert 등을 띄우기
        //    }
        func addMemo(uuid: String, title: String, comment: String, url: URL?, thumbURL: URL?, notificationCycle: Int, notificationPreset: Int, isPinned: Bool) {
            let params = CreateMemoRequest(type: "uuid", identifier: uuid, isPinned: isPinned, title: title, comment: comment, url: url?.absoluteString ?? "", notiCycle: notificationCycle, notiPreset: notificationPreset, notiCount: 0)
            
            NetworkManager.shared.memo_provider.request(.createMemo(params: params)) { result in
                switch result {
                case .success(let response):
                    do {
                        let memo = try JSONDecoder().decode(Memo.self, from: response.data)
                        DispatchQueue.main.async {
                            self.memos.append(memo)
                        }
                    } catch {
                        print("Error adding memo: \(error)")
                    }
                case .failure(let error):
                    print("Error adding memo: \(error)")
                }
            }
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
        
        //    func deleteMemo(uuid: String!, memo_id: Int) {
        //        /// TODO :: User의 UUID와 memo_id를 받아서 삭제
        //
        //        /// DELETE /memo/:memo_id
        //        /// queryString : type=uuid&identifier={uuid}
        //
        //        /// 성공적으로 삭제했다면, 리스트에서 메모 삭제
        //        /// 실패했다면 alert 등을 띄우기
        //    }
        
        func deleteMemo(uuid: String, memoId: Int) {
            NetworkManager.shared.memo_provider.request(.deleteMemo(type: "uuid", identifier: uuid, memo_id: memoId)) { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.memos.removeAll(where: { $0.id == memoId })
                    }
                case .failure(let error):
                    print("Error deleting memo: \(error)")
                }
            }
        }
    }
}
