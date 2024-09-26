//
//  SectionDivider.swift
//  Moonshot
//
//  Created by Matthew Zierl on 9/25/24.
//

import SwiftUI

struct SectionDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    SectionDivider()
}
