//
//  QuestionView.swift
//  MathTables
//
//  Created by Matthew Zierl on 9/15/24.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    
    @State private var presentedNumbers = [1, 4, 8]
    
    var body: some View {
        NavigationStack(path: $presentedNumbers) {
            List(1..<50) { i in
                NavigationLink(value: i) {
                    Label("Row \(i)", systemImage: "\(i).circle")
                }
            }
            .navigationDestination(for: Int.self) { i in
                Text("Detail \(i)")
            }
            .navigationTitle("Navigation")
        }
    }
}

#Preview {
    QuestionView()
}
