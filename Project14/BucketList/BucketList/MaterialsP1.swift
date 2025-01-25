//
//  MaterialsP1.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/18/25.
//

import SwiftUI

struct User: Comparable, Identifiable {
    
    static func < (lhs: User, rhs: User) -> Bool {
        if lhs.lastName < rhs.lastName {
            return true
        } else if (lhs.lastName == rhs.lastName) {
            return lhs.firstName < rhs.firstName
        }
        return false
    }
    
    
    var id = UUID()
    var firstName: String
    var lastName: String
    
}

struct MaterialsP1: View {
    
    let users = [
        User(firstName: "Matthew", lastName: "Zierl"),
        User(firstName: "John", lastName: "Doe"),
        User(firstName: "Jane", lastName: "Doe"),
        User(firstName: "Alice", lastName: "Wonderland"),
        User(firstName: "Bob", lastName: "Dylan"),
        User(firstName: "Charlie", lastName: "Brown"),
    ].sorted()
    
    var body: some View {
        List(users) {
            Text($0.lastName + ", " + $0.firstName)
        }
    }
}

#Preview {
    MaterialsP1()
}
