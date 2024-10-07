//
//  HabitGalleryView.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/2/24.
//

import SwiftUI

struct HabitGalleryView: View {
    
    let layout = [GridItem(.adaptive(minimum: 80))]

    @Binding var habits: [Habit]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(habits) { habit in
                    NavigationLink(value: habit) {
                        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
                            ProgressView(habit: $habits[index])
                                .padding(.top, 2)
                                .padding(.bottom, 2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var habits = [
        Habit(name: "SwiftUI", goal: 10, progress: 4, color: .blue, description: "framework"),
        Habit(name: "Gym", goal: 80, progress: 80, color: .red, description: "lift"),
        Habit(name: "UIKit", goal: 60, progress: 50, color: .green, description: "other framework"),
        Habit(name: "Japanese", goal: 160, progress: 110, color: .cyan, description: "Learn language")
    ]
    HabitGalleryView(habits: $habits)
}
