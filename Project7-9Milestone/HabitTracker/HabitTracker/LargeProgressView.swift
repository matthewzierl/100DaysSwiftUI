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
                .stroke(lineWidth: 16)
                .opacity(0.3)
                .foregroundColor(.gray)
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0.0, to: progressPercentage)
                .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                .foregroundColor(habit.color.toColor())
                .rotationEffect(Angle(degrees: -90))
                .frame(width: 250, height: 250)
                .animation(.easeInOut, value: progressPercentage)
            VStack {
                Text("\(Int(habit.progress)) / \(Int(habit.goal))")
                    .foregroundStyle(.white)
                    .font(.title)
                    .bold()
            }
        }
        .frame(width: 300, height: 300)
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Example", goal: 5, progress: 1, color: HabitColor(color: .blue), description: "description")
    LargeProgressView(habit: $habit)
}
