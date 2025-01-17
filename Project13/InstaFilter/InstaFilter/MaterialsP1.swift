//
//  MaterialsP1.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/12/25.
//

import SwiftUI

struct MaterialsP1: View {
        
    @State private var blurAmount = 0.0
    
    var body: some View {
        VStack {
            Text("Hello World")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
                .onChange(of: blurAmount) { old, new in
                    print("New value is \(new)")
                }
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    MaterialsP1()
}
