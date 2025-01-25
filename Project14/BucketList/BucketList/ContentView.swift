//
//  ContentView.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/18/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.709282, longitude: 139.712463), span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta: 4))
    )
    
    @State private var viewModel: ContentView.ViewModel = ViewModel() // from extension of ContentView
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture(minimumDuration: 0.2) {
                                        viewModel.selectedPlace = location
                                    }
                            }
                        }
                        
                    }
                    .mapStyle(viewModel.currentMapType)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            // call viewModel function
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { oldLocation in // optional binding, but swift automatically unwraps binding, so no need for guard/if let statements
                        // oldLocation is the selectedLocation that the user may change
                        EditView(location: oldLocation) { editedLocation in
                            // call viewModel function
                            viewModel.updateLocation(location: editedLocation)
                        }
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Menu("Map Type") {
                            Button("Hybrid") {
                                viewModel.currentMapType = .hybrid(elevation: .realistic)
                            }
                            Button("Imagery") {
                                viewModel.currentMapType = .imagery
                            }
                            Button("Standard") {
                                viewModel.currentMapType = .standard
                            }
                        }
                        .padding()
                        .background(.black)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                    }
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
