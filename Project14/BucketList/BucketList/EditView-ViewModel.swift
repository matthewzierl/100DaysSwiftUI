//
//  File.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/24/25.
//

import Foundation

extension EditView {
    
    @Observable
    class ViewModel {
        
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var loadingState: LoadingState = .loading
        var pages = [Page]()
        
        var name: String
        var description: String
        var location: Location
        var onSave: (Location) -> Void
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            self.name = location.name
            self.description = location.description
        }
        
        func save() {
            var newLocation = location // copy id, lat & long
            newLocation.id = UUID() // create new id
            newLocation.name = name
            newLocation.description = description
            onSave(newLocation)
        }
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let items = try JSONDecoder().decode(Result.self, from: data)
                
                pages = items.query.pages.values.sorted()
                
                loadingState = .loaded
            } catch {
                print("Could not decode JSON: \(error)")
                loadingState = .failed
            }
        }
        
    }
}
