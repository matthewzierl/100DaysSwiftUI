//
//  MaterialsP4.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/14/25.
//

import SwiftUI

struct MaterialsP4: View {
    var body: some View {
//        ContentUnavailableView("No Snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet"))
        ContentUnavailableView {
            Label("No Snippets", systemImage: "swift")
        } description: {
            Text("You don't have any snippets yet")
        } actions: {
            Button("Create Snippet") {
                createSnippet()
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func createSnippet() {
        
    }
}

#Preview {
    MaterialsP4()
}
