//
//  MemoViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation
import Moya

import CoreData

class MemoViewModel: ObservableObject {
    static let shared = MemoViewModel()//싱글톤 패턴으로 앱의 어느곳에서나 MemoViewModel.shared를 통해 같은 인스턴스에 접근할 수 있음
    let container: NSPersistentContainer
    
    
    @Published var memos: [MemoEntity] = []
    
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("SUCCESSFULLY LOADED CORE DATA. \(description)")
            }
        }
        
    }

    /// CORE DATA 관련 코드
    
    // 1. Core Data 에서 데이터 가져오기
    private func fetchMemo() {
        
        let request = NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
        
        // container에 request 한 것을 fetch해서 가져오기!
        do {
            self.memos = try container.viewContext.fetch(request)
        } catch {
            print("ERROR FETCHING CORE DATA: \(error)")
        }
    }
    
    
    // 2. Core Data 저장하기
    private func save() {
        do {
            try container.viewContext.save()
            fetchMemo()
        } catch {
            print("ERROR on SAVING: \(error)")
        }
    }
    
    
    private func requestUserMemos(uuid: String) {
//        NetworkManager.shared.memo_provider.request(.loadMemo(type: "uuid", identifier: uuid)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let memos = try JSONDecoder().decode([Memo].self, from: response.data)
//                    DispatchQueue.main.async {
//                        self.memos = memos
//                    }
//                    print(memos)
//                } catch {
//                    print("Error decoding memos: \(error)")
//                }
//            case .failure(let error):
//                print("Error loading memos: \(error)")
//            }
//        }
        fetchMemo()
    }
    
    func browseMemosFromServer(uuid: String) {
        requestUserMemos(uuid: uuid)
    }
    
    // TODO :: Memo -> MemoEntity 전환 중 반환값 임시 교체
    func getMemoList() -> [Memo] {
        return []
    }
    
    
    // TODO :: Memo -> MemoEntity 전환 중 반환값 임시 교체
    func updateMemo(uuid: String, memoId: Int, title: String?, comment: String?, url: String?, thumbURL: String?, notificationCycle: Int?, notificationPreset: Int?) {
//        NetworkManager.shared.memo_provider.request(
//            .updateMemo(
//                type: "uuid",
//                identifier: uuid,
//                memo_id: memoId,
//                title: title,
//                comment: comment,
//                url: URL(string: url ?? "")?.absoluteURL,
//                thumbURL: URL(string: thumbURL ?? "")?.absoluteURL,
//                noti_cycle: notificationCycle,
//                noti_preset: notificationPreset)
//        ) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let updatedMemo = try JSONDecoder().decode(Memo.self, from: response.data)
//                    DispatchQueue.main.async {
//                        if let index = self.memos.firstIndex(where: { $0.id == updatedMemo.id }) {
//                            self.memos[index] = updatedMemo
//                        }
//                    }
//                } catch {
//                    print("Error updating memo: \(error)")
//                }
//            case .failure(let error):
//                print("Error updating memo: \(error)")
//            }
//        }
        
    }

    
    // 3. ADD CORE DATA (참고용!!!)
    func addMemo(title: String, comment: String, url: URL?, thumbURL: URL?, notificationCycle: Int, notificationPreset: Int? = nil, isPinned: Bool) {

        let newMemo = MemoEntity(context: container.viewContext)
        newMemo.title = title
        newMemo.comment = comment
        newMemo.url = url ?? URL(string: "")
        newMemo.thumbURL = thumbURL
        newMemo.noti_cycle = Int32(notificationCycle)
        newMemo.noti_preset = nil // 오른쪽 처럼 구현해야함!!! AlarmPresetViewModel.shared.getAlarmPresetList(id: notificationPreset)
        newMemo.isPinned = isPinned
        
        save()
    }
    
    func editMemo(
        uuid: String!,
        memo_id: Int,
        title: String?,
        comment: String?,
        url: URL? = URL(string:""),
        thumbURL: URL? = URL(string: ""),
        noti_cycle: Int?,
        noti_preset: Int?) {
        
        // 1. 기존 메모 불러오기
        // 2. 내용 수정하기
        // 3. save()
            
    }
        
        
    func deleteMemo(uuid: String, memoId: Int) {
//        NetworkManager.shared.memo_provider.request(.deleteMemo(type: "uuid", identifier: uuid, memo_id: memoId)) { result in
//            switch result {
//            case .success:
//                DispatchQueue.main.async {
//                    self.memos.removeAll(where: { $0.id == memoId })
//                }
//            case .failure(let error):
//                print("Error deleting memo: \(error)")
//            }
//        }
    }
}
