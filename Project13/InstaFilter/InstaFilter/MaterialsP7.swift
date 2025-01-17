//
//  MaterialsP7.swift
//  InstaFilter
//
//  Created by Matthew Zierl on 1/14/25.
//

import StoreKit
import SwiftUI

struct MaterialsP7: View {
    
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave Review") { // SHOULD NOT call w/ button usually, instead call at appropriate time in app lifecycle
            requestReview()
        }
    }
}

#Preview {
    MaterialsP7()
}
