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

struct Materials: View {
    @State private var results = [Result]()
    
    var body: some View {
        AsyncImage(url: URL(string: "https://www.hackingwithswift.com/samples/img/logo.png")) { phase in
            if let image = phase.image { // have an image
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil { // error
                Text("There was an error loading the image")
            } else { // loading
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
                AsyncImage(url: URL(string: item.artworkUrl100))
            }
        }
        .task {
            await loadData() // 'await' means a sleep might occur
        }
    }
    
    func loadData() async { // 'async' might go to 'sleep'
        
        guard let url = URL(string: "https://itunes.apple.com/search?term=travis+scott&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            } else {
                print("Cannot decode data")
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

#Preview {
    Materials()
}
