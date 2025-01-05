//
//  Student.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/2/25.
//

import Foundation
import SwiftData

@Model
class Student {
    
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
