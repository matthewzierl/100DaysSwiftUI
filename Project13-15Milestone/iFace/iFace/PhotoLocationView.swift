//
//  PhotoLocationView.swift
//  iFace
//
//  Created by Matthew Zierl on 2/4/25.
//

import MapKit
import SwiftUI

struct PhotoLocationView: View {
    
    var location: MapCameraPosition
    
    var body: some View {
        Map(initialPosition: location) {
            Marker("Location", coordinate: CLLocationCoordinate2D(latitude: location.region!.center.latitude, longitude: location.region!.center.longitude))
                .annotationTitles(.hidden)
        }
    }
}
