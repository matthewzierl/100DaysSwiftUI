//
//  Habit.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct Habit: Identifiable, Hashable, Encodable, Decodable {
    var id = UUID().uuidString
    var name: String
    var goal: Double
    var progress: Double
    var color: HabitColor
    var description: String
    
    init(name: String, goal: Double, progress: Double, color: HabitColor, description: String) {
        self.name = name
        self.goal = goal
        self.progress = progress
        self.color = color
        self.description = description
    }
}

struct HabitColor: Encodable, Decodable, Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double
    
    init(color: Color) {
        let components = UIColor(color).cgColor.components
        self.red = Double(components?[0] ?? 0)
        self.green = Double(components?[1] ?? 0)
        self.blue = Double(components?[2] ?? 0)
        self.opacity = Double(components?[3] ?? 1)
    }
    
    func toColor() -> Color {
        return Color(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
