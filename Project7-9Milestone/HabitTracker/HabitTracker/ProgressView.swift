//
//  ProgressView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct ProgressView: View {
    
    @Binding var habit: Habit
    
    var progressPercentage: Double {
        return Double(habit.progress) / Double(habit.goal)
    }
    
    var body: some View {
        Group {
            VStack {
                Text(habit.name)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .bold()
                    .padding(.top, 5)
                ZStack {
                    Circle()
                        .stroke(lineWidth: 7)
                        .opacity(0.3)
                        .foregroundColor(.gray)
                        .frame(width: 55, height: 55)
                    
                    // Foreground Circle (progress)
                    Circle()
                        .trim(from: 0.0, to: progressPercentage)  // Show only the part of the circle corresponding to progress
                        .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                        .foregroundColor(habit.color)
                        .rotationEffect(Angle(degrees: -90))  // Rotate to start the progress from the top (12 o'clock)
                        .frame(width: 55, height: 55)
                        .animation(.easeInOut, value: progressPercentage)  // Animate the progress change
                    
                    // Text showing progress
                    VStack {
                        Text("\(Int(habit.progress)) / \(Int(habit.goal))")
                            .foregroundStyle(.white)
                            .font(.caption)
                            .bold()
                    }
                }
            }
        }
        .frame(width: 100, height: 100)
        .background(.lightBackground)
        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)))
        .shadow(color: .white, radius: 2)
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Japanese", goal: 120, progress: 40, color: .red, description: "Learning Japanese")
    ProgressView(habit: $habit)
}

