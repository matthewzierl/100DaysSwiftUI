//
//  ContentView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var habits = [Habit]()
    @State private var addHabitSheet = false
    
    let columns = [GridItem(.adaptive(minimum: 100))]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(habits) { habit in
                        NavigationLink(value: habit) {
                            ProgressView(habit: habit)
                        }
                        .background(.red)
                    }
                }
            }
            
            .navigationTitle("HabitTracker")
            .navigationDestination(for: Habit.self) { habit in
                HabitDetailView(habit: habit)
            }
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    addHabitSheet.toggle()
                }
            }
            .sheet(isPresented: $addHabitSheet) {
                AddHabit(habits: $habits)
            }
        }
    }
}

#Preview {
    ContentView()
}
