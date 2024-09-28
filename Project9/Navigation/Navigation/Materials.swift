//
//  Materials.swift
//  Navigation
//
//  Created by Matthew Zierl on 9/27/24.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
    
    init(id: UUID = UUID(), name: String, age: Int) {
        print("Creating student with name: \(name)")
        self.id = id
        self.name = name
        self.age = age
    }
}

struct DetailView: View {
    
    var number: Int
    
    var body: some View {
        Text("Detail View \(number)")
    }
    
    init(number: Int) {
        print("Creating detail view with number: \(number)")
        self.number = number
    }
}

struct Materials: View {
    var body: some View {
        NavigationStack {
            List(0 ..< 100) { index in
                NavigationLink("Select \(index)", value: index)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) { student in
                Text("You selected \(student.name)")
            }
        }
    }
}

//struct Materials: View {
//    var body: some View {
//        NavigationStack {
//            List(0 ..< 1000) { index in // creates detail view when loading... we don't want that...
//                NavigationLink() {
//                    DetailView(number: index)
//                } label: {
//                    Text("test")
//                }
//            }
//        }
//    }
//}

#Preview {
    Materials()
}
