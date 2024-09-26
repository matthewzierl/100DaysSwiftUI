//
//  ContentView.swift
//  Moonshot
//
//  Created by Matthew Zierl on 9/22/24.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json") // type annotation required for generic type methods
    let missions: [Mission] = Bundle.main.decode("missions.json") // uses generic method to accomplish each call
    
    
    
    @State var isGrid = true
    
    var body: some View {
        NavigationStack {
            
            Group {
                if isGrid { // grid view
                    MissionsGridView(astronauts: astronauts, missions: missions)
                } else { // list view
                    MissionsListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                if isGrid {
                    Button("List", systemImage: "list.bullet") {
                        // change to list view
                        
                        isGrid = false
                    }
                } else {
                    Button("Grid", systemImage: "square.grid.2x2") {
                        // change to grid view
                        isGrid = true
                    }
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
