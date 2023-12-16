//
//  AddMemoViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 2023/11/21.
//

import Foundation

class AddMemoViewModel: ObservableObject {
    @Published var memoType: String = ""
    @Published var link: String = ""
    @Published var memoTitle: String = ""
    @Published var memoContent: String = ""
    @Published var selectedReminder: String = ""
    @Published var isEditing: Bool = true
    @Published var tags: [TagEntity] = [] // tags를 [TagEntity]로 변경
    private let memoViewModel = MemoViewModel.shared
    
    func addNewMemo() {
        let url = URL(string: link)
        
        // 메모 타입, 내용, URL 등을 사용하여 새 메모 추가
        MemoViewModel.shared.addMemo(
            title: memoTitle, // 메모 타입
            comment: memoContent, // 메모 내용
            url: url, // 메모 URL
            notificationCycle: 0, // 알림 주기, 예시로 0 사용
            notificationPreset: 0, // 알림 프리셋, 예시로 0 사용
            isPinned: false, // 고정 여부, 예시로 false 사용
            tags: tags // [TagEntity]를 NSSet으로 변환하여 사용
        )
    }


    private func convertReminderToCycle(reminder: String) -> Int {
        // 알림 주기 문자열을 숫자로 변환하는 로직
        switch reminder {
        case "7일":
            return 7
        case "14일":
            return 14
            // 다른 주기에 대한 처리...
        default:
            return 0 // '없음' 또는 처리되지 않은 경우
        }
    }
}
