//
//  Mission.swift
//  Moonshot
//
//  Created by Matthew Zierl on 9/23/24.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
    
    struct CrewRole: Codable, Hashable { // struct w/i struct
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        return "Apollo \(id)"
    }
    var image: String {
        return "apollo\(id)"
    }
    var formattedLaunchDate: String {
        return launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
