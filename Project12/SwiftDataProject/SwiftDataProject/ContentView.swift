//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Matthew Zierl on 1/5/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    
    var body: some View {
        
        NavigationStack() {
            
            UsersView(minimumJoinData: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
            
                .navigationTitle("Users")
                .navigationDestination(for: User.self) { user in
                    EditUserView(user: user)
                }
                .toolbar {
                    Button("Add Samples", systemImage: "plus") {
                        
                        try? modelContext.delete(model: User.self)
                        
                        let first = User(name: "Matt", city: "Madison", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = User(name: "Leah", city: "Milwaukee", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Cody", city: "San Francisco", joinDate: .now.addingTimeInterval(86400 * 5))
                        let fourth = User(name: "Nags", city: "Bangkok", joinDate: .now.addingTimeInterval(86400 * 10))
                        
                        modelContext.insert(first)
                        modelContext.insert(second)
                        modelContext.insert(third)
                        modelContext.insert(fourth)
                    }
                    
                    Button(showingUpcomingOnly ? "Show Everyone": "Show Upcoming") {
                        showingUpcomingOnly.toggle()
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name")
                                .tag ([
                                    SortDescriptor(\User.name),
                                    SortDescriptor(\User.joinDate)
                                ])
                            Text("Join Date")
                                .tag([
                                    SortDescriptor(\User.joinDate),
                                    SortDescriptor(\User.name)
                                ])
                        }
                    }
                }
        }
    }
    
    func save() {
        do {
            try modelContext.save()
            print("-----USER SAVED-----")
        } catch {
            print("Counld not save changes: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
