//
//  AddContactView.swift
//  iFace
//
//  Created by Matthew Zierl on 2/2/25.
//

import SwiftData
import SwiftUI
import PhotosUI

struct AddContactView: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var processedImage: Image?
    
    @State private var imageData: Data?
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var relationship: Relationship? = nil
    @State private var contactDescription: String = ""
    
    @Environment(\.modelContext) var context
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                HStack {
                    Spacer()
                    
                    if let processedImage {
                        VStack {
                            processedImage
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
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                }
                Section() {
                    Picker("Relationship", selection: $relationship) {
                        Text("Select a relationship").tag(nil as Relationship?) // default
                        ForEach(Relationship.allCases, id: \.self) { relationshipType in
                            Text(relationshipType.rawValue)
                                .tag(relationshipType)
                        }
                    }
                }
                Section("Additional Notes") {
                    TextEditor(text: $contactDescription)
                }
            }
            
            
            .onChange(of: selectedItem) {
                loadImage()
            }
            .navigationTitle("Add Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        let newContact = Contact(firstName: firstName, lastName: lastName, imageData: imageData, relationshipType: relationship, contactDescription: contactDescription)
                        context.insert(newContact)
                        dismiss()
                    }
                    .disabled(firstName.isEmpty)
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
            imageData = rawData
        }
    }
}

#Preview {
    AddContactView()
}
