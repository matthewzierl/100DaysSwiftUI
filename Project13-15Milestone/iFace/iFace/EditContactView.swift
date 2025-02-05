//
//  EditContactView.swift
//  iFace
//
//  Created by Matthew Zierl on 2/3/25.
//

import PhotosUI
import SwiftUI

struct EditContactView: View {
    
    @Bindable var contact: Contact
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                HStack {
                    Spacer()
                    
                    if let photo = contact.photo {
                        VStack {
                            photo
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                            Text("Replace Photo")
                        }
                    } else {
                        VStack {
                            Image(.defaultpfp)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                            Text("Add Photo")
                        }
                    }
                    
                    Spacer()
                }
            }
            Form {
                Section() {
                    TextField("First name", text: $contact.firstName)
                    TextField("Last name", text: $contact.lastName)
                }
                Section() {
                    Picker("Relationship", selection: $contact.relationshipType) {
                        if let currentRelationship = contact.relationshipType {
                            Text(currentRelationship.rawValue)
                                .tag(currentRelationship)
                        } else {
                            Text("Select a relationship").tag(nil as Relationship?) // default
                        }
                        ForEach(Relationship.allCases, id: \.self) { relationshipType in
                            Text(relationshipType.rawValue)
                                .tag(relationshipType)
                        }
                    }
                }
                Section("Additional Notes") {
                    TextEditor(text: $contact.contactDescription)
                }
            }
            
            
            .onChange(of: selectedItem) {
                loadImage()
            }
            .navigationTitle("Edit Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        try? context.save()
                        dismiss()
                    }
                }
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let rawData = try await selectedItem?.loadTransferable(type: Data.self) else {
                print("Could not load raw data from image")
                return
            }
            guard let image = UIImage(data: rawData) else {
                print("Could not convert raw data to UIImage")
                return
            }
            processedImage = Image(uiImage: image)
            contact.imageData = rawData
        }
    }
}

#Preview {
    EditContactView(contact: .exampleContact)
}
