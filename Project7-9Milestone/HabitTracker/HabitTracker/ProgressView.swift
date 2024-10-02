//
//  ProgressView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct ProgressView: View {
    
    @State var habit: Habit
    
    var progressPercentage: Double {
        return Double(habit.progress) / Double(habit.goal)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
            
            // Foreground Circle (progress)
            Circle()
                .trim(from: 0.0, to: progressPercentage)  // Show only the part of the circle corresponding to progress
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(habit.color)
                .rotationEffect(Angle(degrees: -90))  // Rotate to start the progress from the top (12 o'clock)
                .frame(width: 100, height: 100)
                .animation(.easeInOut, value: progressPercentage)  // Animate the progress change

            // Text showing progress
            VStack {
                Text("\(habit.progress) / \(habit.goal)")
                    .font(.title3)
                    .bold()
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Japanese", goal: 120, progress: 40, color: .red, description: "Learning Japanese")
    ProgressView(habit: habit)
}

