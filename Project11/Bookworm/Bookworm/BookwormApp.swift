//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/1/25.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
//            MaterialsP2()
//            MaterialsP3()
        }
        .modelContainer(for: Book.self)
    }
}
