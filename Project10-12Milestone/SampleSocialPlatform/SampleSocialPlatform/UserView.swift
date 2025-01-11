//
//  UserView.swift
//  SampleSocialPlatform
//
//  Created by Matthew Zierl on 1/10/25.
//

import SwiftUI

struct UserView: View {
    
    var user: User
    var imageURL = URL(string: "https://100k-faces.glitch.me/random-image")! // i know this is correct for force unwrap
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    AsyncImage(url: imageURL) { face in
                        face
                            .resizable()
                            .scaledToFit()
                            .clipShape(.circle)
                            .shadow(color: user.isActive ? Color.green : Color.red, radius: 10)
//                            .frame(width: 275, height: 225)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Date Registered: \(user.dateRegistered, style: .date)")
                    
                    Text("Friends (\(user.friends.count)):")
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                    
                    
                    
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    UserView()
//}
