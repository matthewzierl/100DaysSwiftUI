//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/23/25.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit
import _MapKit_SwiftUI


extension ContentView {
    
    @Observable
    class ViewModel {
        
        private(set) var locations: [Location] // can read and set, but not change, init initializes it
        var selectedPlace: Location?
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        var isUnlocked = false
        
        var currentMapType: MapStyle = .standard
        
        
        func addLocation(at coordinate: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
            locations.append(newLocation)
            save()
        }
        
        func updateLocation(location: Location) {
            
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
            
        }
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = [] // start w/ empty array (never init before)
            }
        }
        
        func save() {
            
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Could not save places: \(error.localizedDescription)")
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                
                let reason = "Please authenticate yourself to unlock your places"
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                    }
                }
            } else {
                // no biometrics
            }
        }
        
        
    }
    
}
