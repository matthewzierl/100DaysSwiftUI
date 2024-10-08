//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @Binding var habit: Habit
    @Binding var timeBank: TimeInterval
    @State private var editHabit: Bool = false
    
    
    var body: some View {
        
        
        
        VStack {
            
            LargeProgressView(habit: $habit)

            TimerView(habit: $habit, timeBank: $timeBank)
            List() {
                Section("Progress") {
                    Text("\(habit.progress.formatted())")
                }
                Section("Goal") {
                    Text("\(habit.goal.formatted())")
                }
                Section("Description") {
                    Text(habit.description)
                }
            }
            
        }
        .navigationTitle(habit.name)
        .toolbar {
            Button("Edit") {
                editHabit.toggle()
            }
        }
        .sheet(isPresented: $editHabit) {
            EditHabit(habit: $habit)
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Example", goal: 5, progress: 1, color: HabitColor(color: .blue), description: "description")
    @Previewable @State var timeBank: TimeInterval = 0
    HabitDetailView(habit: $habit, timeBank: $timeBank)
}
