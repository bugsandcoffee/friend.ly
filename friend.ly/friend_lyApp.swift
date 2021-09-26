//
//  friend_lyApp.swift
//  friend.ly
//
//  Created by Bugs and Coffee on 2021-09-24.
//

import SwiftUI
import Firebase

@main
struct friend_lyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
