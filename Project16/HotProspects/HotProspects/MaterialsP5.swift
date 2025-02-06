//
//  MaterialsP5.swift
//  HotProspects
//
//  Created by Matthew Zierl on 2/5/25.
//

import SwiftUI

struct MaterialsP5: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button("Red", systemImage: "checkmark.circle.fill", role: .destructive) {
                        backgroundColor = .red
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

#Preview {
    MaterialsP5()
}
