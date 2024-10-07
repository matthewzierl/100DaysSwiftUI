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
    
    
    var body: some View {
        
        
        
        VStack {
            
            LargeProgressView(habit: $habit)
            
            TimerView(habit: $habit, timeBank: $timeBank)
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Example", goal: 5, progress: 1, color: .blue, description: "description")
    @Previewable @State var timeBank: TimeInterval = 0
    HabitDetailView(habit: $habit, timeBank: $timeBank)
}
