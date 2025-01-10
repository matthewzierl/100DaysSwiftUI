//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Matthew Zierl on 1/5/25.
//

import SwiftData
import SwiftUI

struct EditUserView: View {
    
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        let user = User(name: "Matthew Zierl", city: "Madison", joinDate: Date.now)
        
        return EditUserView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Count not create model container: \(error.localizedDescription)")
    }
}
