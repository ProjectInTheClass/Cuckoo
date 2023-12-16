//
//  MemoDetailViewModel.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/02.
//

import Foundation
import Combine
import CoreData

class MemoDetailViewModel: ObservableObject {
    @Published var memo: MemoEntity
    @Published var allTags: [Tag] = []
    @Published var tags: [Tag] = []
    @Published var isEditing = false
    @Published var showActionButtons = false
    @Published var showDeleteAlert = false
    @Published var selectedReminder: String // 선택된 알람 주기를 저장
    
    private let tagViewModel = TagViewModel.shared
    private var cancellables = Set<AnyCancellable>()
    let reminderOptions = ["없음", "7일", "14일", "21일", "30일"]

    let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    init(memoID: NSManagedObjectID, memo: MemoEntity) {
        self.memo = memo
        self.allTags = []
        self.tags = []
        self.isEditing = false
        self.showDeleteAlert = false
        self.showActionButtons = false
        self.selectedReminder = "7일"
    }

    func toggleEditing() {
        isEditing.toggle()
    }

    func toggleActionButtons() {
        showActionButtons.toggle()
    }

    func toggleDeleteAlert() {
        showDeleteAlert.toggle()
    }
    
    func saveChanges() {
        // TODO :: Memo Core data 테스트를 위해 임시 주석
        MemoViewModel.shared.editMemo(
            memoId: memo.objectID,
            title: memo.title,
            comment: memo.comment,
            url: memo.url,
            noti_cycle: Int(memo.noti_cycle),
            noti_preset: memo.noti_preset
        )
    }



    func deleteMemo() {
        MemoViewModel.shared.deleteMemo(memoId: memo.objectID)
    }
    

    private func loadTagsForMemo(memoId: Int) {
        // 메모와 연관된 태그 로드
        tagViewModel.loadTagsForMemo(memoId: memoId)
        // 결과를 관찰하여 tags 배열 업데이트
        tagViewModel.$tags.receive(on: RunLoop.main).sink { [weak self] loadedTags in
            self?.tags = loadedTags
        }.store(in: &cancellables)
    }
    

}
