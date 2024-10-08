//
//  EditHabit.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/8/24.
//

import SwiftUI

struct EditHabit: View {
    
    @Binding var habit: Habit
    
    @State private var name: String = "Untitled"
    @State private var goal: Double = 10
    @State private var description: String = ""
    @State private var color: Color = .blue
    
    @State private var untitledAlertIsShowing: Bool = false
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Color") {
                    ColorPicker("Color", selection: $color)
                }
                Section("Goal"){
                    Stepper("\(Int(goal)) minutes", value: $goal, in: 10 ... 720, step: 10)
                }
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(height: 250)
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .navigationTitle($name)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button("Delete") {
                        
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        guard name != "" && name != "Untitled" else {
                            untitledAlertIsShowing.toggle()
                            return
                        }
                        habit.name = name
                        habit.goal = goal
                        habit.description = description
                        habit.color = HabitColor(color: color)
                        dismiss()
                    }
                }
            }
            .alert("Please Provide a Name", isPresented: $untitledAlertIsShowing) {
                Button("Okay", role: .cancel) { }
            }
            .onAppear {
                name = habit.name
                goal = habit.goal
                description = habit.description
                color = habit.color.toColor()
            }
        }
    }
}

#Preview {
    @Previewable @State var habits = [Habit(name: "Example", goal: 5, progress: 1, color: HabitColor(color: .blue), description: "description")]
    AddHabit(habits: $habits)
}
