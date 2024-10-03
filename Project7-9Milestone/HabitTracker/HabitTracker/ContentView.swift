//
//  ContentView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    
//    @State private var habits = [Habit]()
    @State private var habits = [
        Habit(name: "SwiftUI", goal: 10, progress: 4, color: .blue, description: "framework"),
        Habit(name: "Gym", goal: 80, progress: 80, color: .red, description: "lift"),
        Habit(name: "UIKit", goal: 60, progress: 50, color: .green, description: "other framework"),
        Habit(name: "Japanese", goal: 160, progress: 110, color: .cyan, description: "Learn language")
    ]
    
    @State private var addHabitSheet = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HabitGalleryView(habits: $habits)
                Spacer()
            }
            .navigationTitle("HabitTracker")
            .navigationDestination(for: Habit.self) { habit in
                if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                    HabitDetailView(habit: $habits[index])
                }
            }
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    addHabitSheet.toggle()
                }
            }
            .sheet(isPresented: $addHabitSheet) {
                AddHabit(habits: $habits)
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
