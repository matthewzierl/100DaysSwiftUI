//
//  MaterialsP3.swift
//  AccessibilitySandbox
//
//  Created by Matthew Zierl on 1/28/25.
//

import SwiftUI

struct MaterialsP3: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels([
            "John Fitzgerald Kennedy",
            "Kennedy",
            "JFK"
        ])
    }
}

#Preview {
    MaterialsP3()
}
