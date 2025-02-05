//
//  MaterialsP2.swift
//  HotProspects
//
//  Created by Matthew Zierl on 2/5/25.
//

import SwiftUI

struct MaterialsP2: View {
    
    enum TabValue {
        case one, two, three
    }
    
    @State private var selection: TabValue = .one
    
    var body: some View {
        
        TabView(selection: $selection) {
            Tab("Tab 1", systemImage: "star", value: .one) {
                VStack {
                    Text("Tab 1")
                    Button("Tab 2") {
                        selection = .two
                    }
                    Button("Tab 3") {
                        selection = .three
                    }
                }
            }
            Tab("Tab 2", systemImage: "square", value: .two) {
                VStack {
                    Button("Tab 1") {
                        selection = .one
                    }
                    Text("Tab 2")
                    Button("Tab 3") {
                        selection = .three
                    }
                }
            }
            Tab("Tab 3", systemImage: "triangle", value: .three) {
                VStack {
                    Button("Tab 1") {
                        selection = .one
                    }
                    Button("Tab 2") {
                        selection = .two
                    }
                    Text("Tab 3")
                }
            }
        }
    }
}

#Preview {
    MaterialsP2()
}
