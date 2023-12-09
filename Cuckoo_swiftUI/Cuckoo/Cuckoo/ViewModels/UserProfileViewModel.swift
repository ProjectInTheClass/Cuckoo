//
//  UserProfileViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//
import SwiftUI
import CoreData

class UserProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var profileImage: UIImage?

    init() {
        if let uuidString = UserDefaults.standard.string(forKey: "user_UUID"),
           let uuid = UUID(uuidString: uuidString) {
            // UserDefaults에서 불러온 UUID로 User 초기화
            self.user = User(id: 1, username: "", uuid: uuid, createdAt: Date())
        } else {
            // UUID가 없는 경우, 빈 User 객체 초기화
            self.user = User(id: 1, username: "", uuid: UUID(), createdAt: Date())
        }

    }

    func createUser(username: String) {
        let serverResponse = postUserToServer(username: username)
        self.user = User(id: serverResponse.id, username: username, uuid: serverResponse.uuid, createdAt: serverResponse.createdAt)

        // UserDefaults에 UUID 저장
        UserDefaults.standard.set(self.user.uuid.uuidString, forKey: "userUUID")
    }

    func getUUID() -> UUID {
        return self.user.uuid
    }

    private func postUserToServer(username: String) -> (id: Int, uuid: UUID, createdAt: Date) {
        // 서버에 POST 요청 보내고 응답 받기
        // 실제 앱에서는 HTTP 요청을 처리하는 로직이 필요함
        // 여기에서는 예시 응답을 반환함
        return (1, UUID(), Date())
    }
}
