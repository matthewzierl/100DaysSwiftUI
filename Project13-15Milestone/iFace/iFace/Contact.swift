//
//  Contact.swift
//  iFace
//
//  Created by Matthew Zierl on 2/1/25.
//

import Foundation
import SwiftData
import SwiftUI

enum Relationship: String, Codable, CaseIterable {
    case parent = "Parent"
    case sibling = "Sibling"
    case child = "Child"
    case friend = "Friend"
    case peer = "Peer"
    case coworker = "Coworker"
    case other = "Other"
}

@Model
class Contact: Comparable, Identifiable, Hashable {
    
    var firstName: String
    var lastName: String
    @Attribute(.externalStorage) var imageData: Data?
    var photo: Image? {
        guard let data = imageData else { return nil }
        guard let convertedImage = UIImage(data: data) else { return nil}
        return Image(uiImage: convertedImage)
    }
    var relationshipType: Relationship?
    var contactDescription: String
    var id: UUID
    
    init(firstName: String, lastName: String, imageData: Data?, relationshipType: Relationship?, contactDescription: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.imageData = imageData
        self.relationshipType = relationshipType
        self.contactDescription = contactDescription
        self.id = UUID()
    }
    
    
    static func <(lhs: Contact, rhs: Contact) -> Bool {
        lhs.firstName < rhs.firstName
    }
    
    static func ==(lhs: Contact, rhs: Contact) -> Bool {
        lhs.firstName == rhs.firstName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    
    static var exampleContact: Contact = Contact(firstName: "John", lastName: "Doe", imageData: nil, relationshipType: .other, contactDescription: "For testing purposes only")
}
