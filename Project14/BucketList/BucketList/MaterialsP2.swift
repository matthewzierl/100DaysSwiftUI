//
//  MaterialsP2.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/18/25.
//

import SwiftUI

struct MaterialsP2: View {
    var body: some View {
        Button("Read & Write") {
            let data = Data("Test Message".utf8)
            let url = URL.documentsDirectory.appending(path: "message.txt")
            
            do {
                try data.write(to: url, options: [.atomic, .completeFileProtection])
                let input = try String(contentsOf: url, encoding: .utf8)
                print(input)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MaterialsP2()
}
