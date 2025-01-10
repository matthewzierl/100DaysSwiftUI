//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Matthew Zierl on 1/5/25.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self, isAutosaveEnabled: true)
        }
//        .modelContainer(for: User.self)
    }
}
