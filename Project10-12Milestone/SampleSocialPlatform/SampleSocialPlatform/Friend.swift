//
//  Friend.swift
//  SampleSocialPlatform
//
//  Created by Matthew Zierl on 1/10/25.
//

import Foundation

struct Friend: Codable, Identifiable {
    
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
}
