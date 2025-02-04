//
//  iFaceApp.swift
//  iFace
//
//  Created by Matthew Zierl on 2/1/25.
//

import SwiftUI

@main
struct iFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Contact.self, isAutosaveEnabled: true)
        }
    }
}
