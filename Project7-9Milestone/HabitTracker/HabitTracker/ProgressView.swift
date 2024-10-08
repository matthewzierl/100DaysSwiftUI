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
                    
                    Circle()
                        .trim(from: 0.0, to: progressPercentage)
                        .stroke(style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                        .foregroundColor(habit.color.toColor())
                        .rotationEffect(Angle(degrees: -90))
                        .frame(width: 55, height: 55)
                        .animation(.easeInOut, value: progressPercentage)
                    
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
    }
}

#Preview {
    @Previewable @State var habit = Habit(name: "Japanese", goal: 120, progress: 40, color: HabitColor(color: .blue), description: "Learning Japanese")
    ProgressView(habit: $habit)
}

