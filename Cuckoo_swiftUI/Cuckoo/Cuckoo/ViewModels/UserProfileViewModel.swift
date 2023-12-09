//
//  UserProfileViewModel.swift
//  Cuckoo
//
//  Created by DKSU on 12/9/23.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    
    @Published var userName: String
    @Published var isEditing: Bool
    
    init() {
        self.userName = "__의 메모장"
        self.isEditing = false
    }
}
