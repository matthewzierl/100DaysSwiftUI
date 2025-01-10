//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Matthew Zierl on 1/6/25.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            NavigationLink(value: user) {
                HStack {
                    
                    Text(user.name)
                    
                    Spacer()
                    
                    Text("Jobs: \(user.jobs.count)")
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
        }
        .onAppear {
            addSample()
        }
    }
    
    init(minimumJoinData: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            if user.joinDate >= minimumJoinData {
                return true
            } else {
                return false
            }
        }, sort: sortOrder)
    }
    
    func addSample() {
        let user1 = User(name: "Yuzumu", city: "Yamanashi", joinDate: .now)
        let job1 = Job(name: "Go to the gym", priority: 3)
        let job2 = Job(name: "Get a girlfriend", priority: 5)
        
        context.insert(user1)
        
        user1.jobs.append(job1)
        user1.jobs.append(job2)
        
//        let user2 = User(name: "Hanon", city: "Fukuoka", joinDate: .now)
//        let user3 = User(name: "Kana", city: "Sapporo", joinDate: .now)
//        let user4 = User(name: "Riko", city: "Sendai", joinDate: .now)
    }
}

#Preview {
    UsersView(minimumJoinData: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
