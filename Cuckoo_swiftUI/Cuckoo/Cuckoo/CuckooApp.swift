//
//  CuckooApp.swift
//  Cuckoo
//
//  Created by 유철민 on 2023/10/30.
//

import SwiftUI

class GlobalState: ObservableObject {
    @Published var isRegistered: Bool = true
}

@main
struct CuckooApp: App {
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
