//
//  CuckooApp.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/10/30.
//

import SwiftUI

class GlobalState: ObservableObject {
    @Published var isRegistered: Bool = false {
        didSet {
            print("Registration State Updated: \(isRegistered)")
            saveRegistrationState()
        }
    }

    init() {
        isRegistered = loadRegistrationState()
        print("App Initialized - isRegistered: \(isRegistered)")
    }

    private func saveRegistrationState() {
        UserDefaults.standard.set(isRegistered, forKey: "isRegistered")
    }

    private func loadRegistrationState() -> Bool {
        return UserDefaults.standard.bool(forKey: "isRegistered")
    }
}

@main
struct CuckooApp: App {
    @StateObject var userViewModel = UserProfileViewModel.shared
    @StateObject var globalState = GlobalState()
    
    var body: some Scene {
        WindowGroup {
            if globalState.isRegistered {
                MainView()
                    .environmentObject(globalState)
            } else {
                Init_AddNameAndTagView()
                    .environmentObject(globalState)
            }
        }
    }
}
