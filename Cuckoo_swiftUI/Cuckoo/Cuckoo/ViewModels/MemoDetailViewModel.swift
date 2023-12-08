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
        memo.title = title
                memo.comment = comment // comment로 변경
                memo.url = link // URL 처리 추가
                
        
        // Save changes to the database or send to the server
    }

    func saveChanges() {
        // 실제 변경 사항을 저장하는 로직
        // 예: updateMemo(...)를 호출하여 데이터베이스에 저장
    }

    func deleteMemo() {
        // Delete the memo from the database or server
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
