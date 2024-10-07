//
//  LargeProgressView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/7/24.
//

import SwiftUI

struct LargeProgressView: View {
    
    @Binding var habit: Habit
    var progressPercentage: Double {
        return Double(habit.progress) / Double(habit.goal)
    }
    
    var body: some View {
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
                    .font(.title)
                    .bold()
            }
        }
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Example", goal: 5, progress: 1, color: .blue, description: "description")
    LargeProgressView(habit: $habit)
}
