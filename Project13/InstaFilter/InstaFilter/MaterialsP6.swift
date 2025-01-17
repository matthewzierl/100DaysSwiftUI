//
//  MaterialsP6.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/14/25.
//

import SwiftUI

struct MaterialsP6: View {
    var body: some View {
        // sharing URL
        ShareLink(item: URL(string: "https://github.com/matthewzierl")!, subject: Text("Check me out on Github"), message: Text("he is so cool")) {
            Label("matthewzierl", systemImage: "person")
        }
        
        // sharing file
        let image = Image(.example)
        
        ShareLink(item: image, preview: SharePreview("Shibuya Crossing", image: image)) {
            Label("Shibuya Crossing", systemImage: "photo")
        }
    }
}

#Preview {
    MaterialsP6()
}
