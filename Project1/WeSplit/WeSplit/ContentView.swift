//
//  ContentView.swift
//  WeSplit
//
//  Created by Matthew Zierl on 8/31/24.
//

import SwiftUI

struct ContentView: View {
    
    let students = ["Harry", "Hermione", "Ron"]
    
    @State private var selectedStudent = "Harry"
    
    var body: some View { // returns a view
        NavigationStack {
            Form {
                Picker("Select Your Student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                    }
                }
                Text("hi")
                Text("sup")
                
            }
        }
    }
}

#Preview {
    ContentView()
}
