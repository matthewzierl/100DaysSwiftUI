//
//  MaterialsP2.swift
//  AccessibilitySandbox
//
//  Created by Matthew Zierl on 1/27/25.
//

import SwiftUI

struct MaterialsP2: View {
    
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("Current Value: \(value)")
            HStack {
                Button("Increment") {
                    value += 1
                }
                Button("Decrement") {
                    value -= 1
                }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled")
            }
        }
    }
}

#Preview {
    MaterialsP2()
}
