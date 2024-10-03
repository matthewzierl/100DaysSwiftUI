//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct HabitDetailView: View {
    
    @Binding var habit: Habit
    
    var progressPercentage: Double {
        return Double(habit.progress) / Double(habit.goal)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 14)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                    .frame(width: 200, height: 200)
                
                // Foreground Circle (progress)
                Circle()
                    .trim(from: 0.0, to: progressPercentage)
                    .stroke(style: StrokeStyle(lineWidth: 14, lineCap: .round, lineJoin: .round))
                    .foregroundColor(habit.color)
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut, value: progressPercentage)
                VStack {
                    Text("\(Int(habit.progress)) / \(Int(habit.goal))")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .bold()
                }
            }
            Text("\(Int(habit.progress)) minutes")
            Button("Add time") {
                habit.progress += 1
            }
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Example", goal: 5, progress: 1, color: .blue, description: "description")
    HabitDetailView(habit: $habit)
}
