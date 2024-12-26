//
//  Day2Materials.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 10/15/24.
//

import SwiftUI

struct Day1p2Materials: View {
    var body: some View {
        //AsyncImage is a wrapper around Image, which contains placeholder image, so modifiers won't work
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    Day1p2Materials()
}
