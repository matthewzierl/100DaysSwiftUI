//
//  Habit.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct Habit: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var goal: Double
    var progress: Double
    var color: Color
    var description: String
    
    init(name: String, goal: Double, progress: Double, color: Color, description: String) {
        self.name = name
        self.goal = goal
        self.progress = progress
        self.color = color
        self.description = description
    }
}
