//
//  MaterialsP2.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/12/25.
//

import SwiftUI

struct MaterialsP2: View {
    
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Button("Hello World") {
            showingConfirmation.toggle()
        }
        .frame(width: 300, height: 300)
        .background(backgroundColor)
        
        .confirmationDialog("Change Color", isPresented: $showingConfirmation) {
            Button("White") {
                backgroundColor = Color.white
            }
            Button("Red") {
                backgroundColor = Color.red
            }
            Button("Blue") {
                backgroundColor = Color.blue
            }
        } message: {
            Text("Change the background color")
        }
    }
}

#Preview {
    MaterialsP2()
}
