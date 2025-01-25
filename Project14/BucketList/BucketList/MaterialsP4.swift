////
////  MaterialsP4.swift
////  BucketList
////
////  Created by Matthew Zierl on 1/19/25.
////
//
//import MapKit
//import SwiftUI
//
//struct Location: Identifiable {
//    var id = UUID()
//    var name: String
//    var coordinate: CLLocationCoordinate2D
//}
//
//struct MaterialsP4: View {
//    
//    @State private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.6583, longitude: 139.6954), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)))
//    
//    let locations = [
//        Location(name: "Atom", coordinate: CLLocationCoordinate2D(latitude: 35.6583, longitude: 139.6954)),
//        Location(name: "Sharehouse", coordinate: CLLocationCoordinate2D(latitude: 35.730027, longitude: 139.799266)),
//        Location(name: "Dorms", coordinate: CLLocationCoordinate2D(latitude: 35.709282, longitude: 139.712463))
//    ]
//    
//    var body: some View {
//        VStack {
//            MapReader { proxy in
//                Map(/*position: $position*/) {
//                    ForEach(locations) { location in
//                        Annotation(location.name, coordinate: location.coordinate) {
//                            Text(location.name)
//                                .font(.headline)
//                                .padding()
//                                .background(.blue.gradient)
//                                .foregroundStyle(.white)
//                                .clipShape(.capsule)
//                        }
//                        .annotationTitles(.hidden)
//                    }
//                }
//                .onTapGesture { position in
//                    if let coordinate = proxy.convert(position, from: .local) {
//                        print(coordinate)
//                    }
//                }
//            }
////                .mapStyle(.hybrid(elevation: .realistic))
////                .onMapCameraChange { context in
////                    print(context.region)
////                }
//            
////            HStack(spacing: 50) {
////                Button("Atom") {
////                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.6583, longitude: 139.6954), span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)))
////                }
////                Button("Sharehouse") {
////                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.730027, longitude: 139.799266), span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001)))
////                }
////                Button("Dorms") {
////                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.709282, longitude: 139.712463), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)))
////                }
////            }
//        }
//    }
//}
//
//#Preview {
//    MaterialsP4()
//}
