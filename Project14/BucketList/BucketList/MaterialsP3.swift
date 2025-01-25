//
//  MaterialsP3.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/19/25.
//

import SwiftUI

struct loadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct successView: View {
    var body: some View {
        Text("Success!")
    }
}

struct failureView: View {
    var body: some View {
        Text("Failure:(")
    }
}

struct MaterialsP3: View {
    
    enum LoadingState {
        case loading, success, failure
    }
    
    @State private var state = LoadingState.loading
    
    var body: some View {
        switch state {
        case .loading:
            loadingView()
        case .success:
            successView()
        case .failure:
            failureView()
        }
    }
}

#Preview {
    MaterialsP3()
}
