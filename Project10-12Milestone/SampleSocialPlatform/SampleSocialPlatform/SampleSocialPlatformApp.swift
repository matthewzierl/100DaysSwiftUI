//
//  SampleSocialPlatformApp.swift
//  SampleSocialPlatform
//
//  Created by Matthew Zierl on 1/10/25.
//

import SwiftUI

@main
struct SampleSocialPlatformApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: User.self, isAutosaveEnabled: true)
        }
    }
}
