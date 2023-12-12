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
    @Published var memoContent: String = ""
    @Published var selectedReminder: String = ""
    private let memoViewModel = MemoViewModel.shared
    
    func addNewMemo() {
        let url = URL(string: link)
        let thumbURL = URL(string: "") // 썸네일 URL은 여기서는 빈 문자열로 처리했습니다.
        print("작성완료")
        // 메모 타입, 내용, URL 등을 사용하여 새 메모 추가
        MemoViewModel.shared.addMemo(
            uuid: "86be72a7-9cae-42e1-ab57-b6d7a0df07b3", // 실제 사용자 UUID로 대체
            title: memoType, // 메모 타입
            comment: memoContent, // 메모 내용
            url: url, // 메모 URL
            thumbURL: thumbURL, // 썸네일 URL
            notificationCycle: 0, // 알림 주기, 예시로 0 사용
            notificationPreset: 0, // 알림 프리셋, 예시로 0 사용
            isPinned: false // 고정 여부, 예시로 false 사용
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


