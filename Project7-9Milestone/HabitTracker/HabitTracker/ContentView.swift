//
//  ContentView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var allHabits = AllHabits()
    
    @State private var addHabitSheet = false
    @State private var timeBank: TimeInterval = 0
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HabitGalleryView(habits: $allHabits.habits)
                LargeTimerView(timeBank: $timeBank)
                Spacer()
            }
            .navigationTitle("HabitTracker")
            .navigationDestination(for: Habit.self) { habit in
                if let index = allHabits.habits.firstIndex(where: { $0.id == habit.id }) {
                    HabitDetailView(habit: $allHabits.habits[index], timeBank: $timeBank)
                }
            }
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    addHabitSheet.toggle()
                }
            }
            .sheet(isPresented: $addHabitSheet) {
                AddHabit(habits: $allHabits.habits)
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
