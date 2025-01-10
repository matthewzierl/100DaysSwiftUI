//
//  User.swift
//  SwiftDataProject
//
//  Created by Matthew Zierl on 1/5/25.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    @Relationship(deleteRule: .cascade) var jobs = [Job]() // cascade - when user model is deleted, all relationships in User and down the line are deleted as well
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
