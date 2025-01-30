//
//  MaterialsP1.swift
//  AccessibilitySandbox
//
//  Created by Matthew Zierl on 1/27/25.
//

import SwiftUI

struct MaterialsP1: View {
    var body: some View {
        VStack {
            Text("Your score is")
            
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore) // .combine combines both with pause between each text, ignore hides everything from accessibility
        .accessibilityLabel("Your score is 1000")
    }
}

#Preview {
    MaterialsP1()
}
