//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Matthew Zierl on 10/1/24.
//

import SwiftUI

struct AddHabit: View {
    
    @Binding var habits: [Habit]
    
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
                        .frame(height: 200)
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
                ToolbarItem(placement: .confirmationAction) {
                    Button("Submit") {
                        guard name != "" && name != "Untitled" else {
                            untitledAlertIsShowing.toggle()
                            return
                        }
                        habits.append(Habit(name: name, goal: goal, progress: 0, color: color, description: description))
                        dismiss()
                    }
                }
            }
            .alert("Please Provide a Name", isPresented: $untitledAlertIsShowing) {
                Button("Okay", role: .cancel) { }
            }
        }
    }
}

#Preview {
    @Previewable @State var habits = [Habit(name: "Example", goal: 5, progress: 1, color: .blue, description: "description")]
    AddHabit(habits: $habits)
}
