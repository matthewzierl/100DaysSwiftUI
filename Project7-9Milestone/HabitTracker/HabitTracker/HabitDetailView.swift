//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    var habit: Habit
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    HabitDetailView(habit: Habit(name: "Example", goal: 5, progress: 1, color: .blue, description: "description"))
}
