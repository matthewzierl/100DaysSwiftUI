//
//  EditView.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/22/25.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: EditView.ViewModel

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loading:
                        ProgressView()
                    case .loaded:
                        List {
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ")
                                + Text(page.description)
                                    .italic()
                            }
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            
            .navigationTitle("Place Details")
            .toolbar {
                Button("Save") {
                    viewModel.save()
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) { // @escaping marks function as NOT being used right now, but later
        _viewModel = State(initialValue: ViewModel(location: location, onSave: onSave))
    }
    
    
}

#Preview {
    EditView(location: .example) { _ in }
}
