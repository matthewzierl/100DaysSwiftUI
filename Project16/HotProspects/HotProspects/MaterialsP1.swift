//
//  MaterialsP1.swift
//  HotProspects
//
//  Created by Matthew Zierl on 2/5/25.
//

import SwiftUI

struct MaterialsP1: View {
    
    var users = ["Matt", "Leah", "Lucas", "Nags", "Cody"]
    
    @State private var selection = Set<String>()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                List(users, id: \.self, selection: $selection) { user in
                    Text(user)
                }
                
                if !selection.isEmpty {
                    Text("You selected: \(selection.formatted())")
                }
            }
            .navigationTitle("Multiple Selection")
            .toolbar {
                EditButton()
            }
        }
    }
}

#Preview {
    MaterialsP1()
}
