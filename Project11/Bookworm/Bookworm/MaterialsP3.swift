//
//  MaterialsP3.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/2/25.
//

import SwiftData
import SwiftUI

struct MaterialsP3: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List(students) { student in
                Text("\(student.name)")
            }
            .navigationTitle("Classroom")
            .toolbar {
                Button("Add") {
                    let firstNames = ["Matthew", "Leah", "Steve", "Angelita"]
                    let lastNames = ["Zierl", "Smith", "Jones", "Williams"]
                    let firstName = firstNames.randomElement()!
                    let lastName = lastNames.randomElement()!
                    
                    let student = Student(id: UUID(), name: "\(firstName) \(lastName)")
                    
                    modelContext.insert(student)
                    try? modelContext.save()
                }
            }
        }
    }
}

#Preview {
    MaterialsP3()
}
