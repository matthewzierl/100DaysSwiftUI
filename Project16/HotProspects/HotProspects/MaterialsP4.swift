//
//  MaterialsP4.swift
//  HotProspects
//
//  Created by Matthew Zierl on 2/5/25.
//

import SwiftUI

struct MaterialsP4: View {
    var body: some View {
        Image(.example)
            .interpolation(.none) // make it not blurry due to upscaling
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    MaterialsP4()
}
