//
//  MemoDummy.swift
//  Cuckoo
//
//  Created by 장동우 on 2023/12/09.
//

import Foundation

let items: [Memo] = [
    Memo(
        id: 1,
        userId: 1,
        title: "PM 스터디 그것이 알고싶다",
        comment: "우아한 형제들 Tech 블로그 나중에 꼭 챙겨보기!",
        url: URL(string: "https://techblog.woowahan.com/13977/"),
        thumbURL: URL(string: "https://techblog.woowahan.com/wp-content/uploads/2021/06/screenshot.jpg"),
        notificationCycle: 7, // 예시 값
        notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
        notificationStatus: "Active", // 예시 상태
        notificationCount: 3, // 예시 횟수
        isPinned: true, // 예시 고정 상태
        createdAt: Date(),
        updatedAt: Date(),
        remainingNotificationTime: Date() // 예시 남은 알림 시간
    ),
    Memo(
        id: 2,
        userId: 1,
        title: "오늘 할일",
        comment: "1. 방 옷 정리하기\n2. 동사무소 16시 이전에 들렸다오기\n3. 소모임 관련 Notion 페이지 손보기",
        url: URL(string: ""),
        thumbURL: URL(string: ""),
        notificationCycle: 7, // 예시 값
        notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
        notificationStatus: "Active", // 예시 상태
        notificationCount: 3, // 예시 횟수
        isPinned: false, // 예시 고정 상태
        createdAt: Date(),
        updatedAt: Date(),
        remainingNotificationTime: Date() // 예시 남은 알림 시간
    ),
    Memo(
        id: 3,
        userId: 1,
        title: "Velog",
        comment: "내가 보려고 정리한 기술 블로그 모음(2022)",
        url: URL(string: "https://velog.io/@esthevely/%EB%82%B4%EA%B0%80-%EB%B3%B4%EB%A0%A4%EA%B3%A0-%EC%A0%95%EB%A6%AC%ED%95%9C-%EA%B8%B0%EC%88%A0-%EB%B8%94%EB%A1%9C%EA%B7%B8-%EB%AA%A8%EC%9D%8C2022"),
        thumbURL: URL(string: "https://velog.velcdn.com/images/esthevely/post/af9eda09-5d6e-464b-91e7-ad14fa2d1e3f/tumblr_nn2mjjJKzq1utwqnuo1_500.gif"),
        notificationCycle: 7, // 예시 값
        notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
        notificationStatus: "Active", // 예시 상태
        notificationCount: 3, // 예시 횟수
        isPinned: false, // 예시 고정 상태
        createdAt: Date(),
        updatedAt: Date(),
        remainingNotificationTime: Date() // 예시 남은 알림 시간
    ),
    Memo(
        id: 4,
        userId: 1,
        title: "Github",
        comment: "클린코드 스터디",
        url: URL(string: "https://github.com/Yooii-Studios/Clean-Code"),
        thumbURL: URL(string: "https://opengraph.githubassets.com/d3065dfb6924c24f6f7ff79247bb370fccdf88295c564036ddfd3c5a19c29057/Yooii-Studios/Clean-Code"),
        notificationCycle: 7, // 예시 값
        notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
        notificationStatus: "Active", // 예시 상태
        notificationCount: 3, // 예시 횟수
        isPinned: false, // 예시 고정 상태
        createdAt: Date(),
        updatedAt: Date(),
        remainingNotificationTime: Date() // 예시 남은 알림 시간
    ),
    Memo(
        id: 5,
        userId: 1,
        title: "Velog",
        comment: "참고하려고 하는 TIL 관련 게시글!",
        url: URL(string: "https://velog.io/@moonstar/TIL-22.12.29"),
        thumbURL: URL(string: "https://images.velog.io/velog.png"),
        notificationCycle: 7, // 예시 값
        notificationTime: ["09:00 AM", "03:00 PM"], // 예시 시간들
        notificationStatus: "Active", // 예시 상태
        notificationCount: 2, // 예시 횟수
        isPinned: false, // 예시 고정 상태
        createdAt: Date(),
        updatedAt: Date(),
        remainingNotificationTime: Date() // 예시 남은 알림 시간
    )
]
