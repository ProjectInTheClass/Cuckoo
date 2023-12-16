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
    @Published var tags: [TagEntity]? = [] // 메모가 갖고있는 태그들임
    @Published var isEditing = false
    @Published var showActionButtons = false
    @Published var showDeleteAlert = false
    @Published var selectedReminder: AlarmPresetEntity? // 선택된 알람 주기를 저장
    
    private let tagViewModel = TagViewModel.shared
    private var cancellables = Set<AnyCancellable>()
    let reminderOptions = ["없음", "7일", "14일", "21일", "30일"]

    let context: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    init(memoID: NSManagedObjectID, memo: MemoEntity) {
        self.memo = memo
        self.isEditing = false
        self.showDeleteAlert = false
        self.showActionButtons = false
        
        if let tagSet = memo.memo_tag as? Set<TagEntity> {
            self.tags = Array(tagSet)
        }
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
        memo.memo_preset = selectedReminder
        
        MemoViewModel.shared.editMemo(
            memoId: memo.objectID,
            title: memo.title,
            comment: memo.comment,
            url: memo.url,
            noti_cycle: Int(memo.noti_cycle),
            noti_preset: memo.memo_preset,
            tags: tags
        )
    }

    func deleteMemo() {
        MemoViewModel.shared.deleteMemo(memoId: memo.objectID)
    }

}
