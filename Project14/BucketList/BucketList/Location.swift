//
//  Location.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/22/25.
//

import Foundation
import MapKit

struct Location: Codable, Equatable, Identifiable {
    
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    #if DEBUG // won't get compiled for release
    static let example = Location(id: UUID(), name: "Atom", description: "Club in Shibuya", latitude: 35.6583, longitude: 139.6954)
    #endif
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
