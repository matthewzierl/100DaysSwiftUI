//
//  UserListView.swift
//  SampleSocialPlatform
//
//  Created by Matthew Zierl on 1/10/25.
//

import SwiftUI

struct UserListView: View {
    
    var user: User
    
    var body: some View {
        HStack {
            Text(user.name)
                .font(.headline)
                .padding()
            Text(user.company)
                .font(.subheadline)
                .padding()
            Spacer()
            Circle()
                .fill(user.isActive ? Color.green : Color.red)
                .frame(width: 10, height: 10)
                .padding()
        }
    }
}

//#Preview {
//    var user = User(id: "123", isActive: true, name: "Matt", age: 22, company: "none", email: "ma@gmail.com", address: "324 Durst Road", about: "swag guy", dateRegistered: .now, tags: ["swag", "cool", "awesome"], friends: [])
//    UserListView(user: user)
//}
