//
//  AllHabits.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/8/24.
//

import SwiftUI

class AllHabits {
    var habits = [Habit]() {
        didSet {
            print("habits now has \(habits.count) items")
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init () {
        let jsonDecoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedItems = try? jsonDecoder.decode([Habit].self, from: data) {
                habits = decodedItems
            } else {
                fatalError("Could not decode habits from data")
            }
        } else {
            habits = [] // empty array
        }
    }
}
