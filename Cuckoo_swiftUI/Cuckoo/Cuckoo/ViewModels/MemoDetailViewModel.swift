//
//  MemoDetailViewModel.swift
//  Cuckoo
//
//  Created by 김경민 on 2023/12/02.
//

import Foundation

class MemoDetailViewModel: ObservableObject {
    @Published var memo: Memo
    @Published var allTags: [Tag]
    @Published var tags: [Tag] = []
    @Published var memoTags: [MemoTag] = []
    @Published var isEditing = false
    @Published var showActionButtons = false
    @Published var showDeleteAlert = false
    @Published var selectedReminder: String // 선택된 알람 주기를 저장
    private let memoViewModel = MemoViewModel.shared
    let reminderOptions = ["없음", "7일", "14일", "21일", "30일"]

    init(memo: Memo, allTags: [Tag] = dummyTags, memoTags: [MemoTag] = dummyMemoTags) {
            self.memo = memo
            self.allTags = allTags
            self.memoTags = memoTags
            self.selectedReminder = ""
            loadTags()
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

    func updateMemo(title: String, comment: String, tags: [String], link: URL?) {
                
    }

    func saveChanges() {
        MemoViewModel.shared.updateMemo(
            uuid: "86be72a7-9cae-42e1-ab57-b6d7a0df07b3",
            memoId: memo.id,
            title: memo.title,
            comment: memo.comment,
            url: memo.url,
            thumbURL: memo.thumbURL,
            notificationCycle: memo.notiCycle,
            notificationPreset: memo.notiPreset
        )
    }



    func deleteMemo() {
        MemoViewModel.shared.deleteMemo(uuid: "86be72a7-9cae-42e1-ab57-b6d7a0df07b3", memoId: memo.id)
    }
    
    func updateTags(forMemo memoId: Int, withTagIds tagIds: [Int]) {
            memoTags = tagIds.map { MemoTag(memoId: memoId, tagId: $0) }
        }

    func loadTags() {
            let relatedMemoTags = memoTags.filter { $0.memoId == memo.id }
            let relatedTagIds = relatedMemoTags.map { $0.tagId }
            tags = allTags.filter { relatedTagIds.contains($0.id) }
        }
    

}
