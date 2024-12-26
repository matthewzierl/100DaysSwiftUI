//
//  Materials.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 10/15/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artworkUrl100: String
}

struct Day1Materials: View {
    @State private var results: [Result] = []
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
                
            }
        }
        
        .task { // a sleep MIGHT occur here
            await loadData()
        }
    }
    
    func loadData() async { // func might want to go to sleep to complete work
        guard let url = URL(string: "https://itunes.apple.com/search?term=osamason&entity=song") else {
            print("Invalid url")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url) // need data, discard meta data about data with '_'
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    Day1Materials()
}
