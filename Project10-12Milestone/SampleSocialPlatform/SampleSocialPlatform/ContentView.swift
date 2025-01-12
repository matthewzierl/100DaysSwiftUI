//
//  ContentView.swift
//  SampleSocialPlatform
//
//  Created by Matthew Zierl on 1/10/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    var socialPlatformURL: URL = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")! // force unwrap because we know this link works
    
    @Query var allUsers: [User]
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(allUsers) { user in
                        NavigationLink(destination: UserView(user: user)) {
                            UserListView(user: user)
                        }
                    }
                }
            
            }
        }
        .task { // perform async task before view appears
            do {
                guard allUsers.isEmpty else {
                    print("USERS ALREADY MANAGED BY SWIFTDATA")
                    return
                } // check not already loaded
                try await loadUsers()
            } catch {
                print("Could not load users: \(error)")
            }
        }
    }
    
    /*
     Requests:
        GET: Download data
        POST: Create New Data & Upload
        PUT: Updating Existing Data
        DELETE: Deleting Existing Data
     
     */
    func loadUsers() async throws {
        
//        var request = URLRequest(url: socialPlatformURL)
//        request.setValue( "Application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(from: socialPlatformURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw SocialPlatformError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let loadedUsers = try decoder.decode([User].self, from: data)
            for user in loadedUsers {
                context.insert(user)
            }
        } catch {
            throw SocialPlatformError.invalidData
        }
    }
    
    enum SocialPlatformError: Error {
        case invalidResponse
        case invalidData
    }
}

#Preview {
    ContentView()
}
