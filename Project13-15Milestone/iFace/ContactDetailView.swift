//
//  ContactDetailView.swift
//  iFace
//
//  Created by Matthew Zierl on 2/3/25.
//

import SwiftUI

struct ContactDetailView: View {
    
    @Bindable var contact: Contact
    
    @State private var showEditContact: Bool = false
    
    
    var body: some View {
        NavigationStack {
            if let photo = contact.photo {
                photo
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            } else {
                Image(.defaultpfp)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
            }
            Form {
                Section("Name") {
                    Text(contact.firstName)
                    Text(contact.lastName)
                }
                Section("Relationship") {
                    Text("\(contact.relationshipType?.rawValue ?? "Unknown")")
                }
                Section("Description") {
                    Text(contact.contactDescription)
                }
            }
            
            .navigationTitle(contact.firstName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Edit") {
                    showEditContact.toggle()
                }
            }
            .fullScreenCover(isPresented: $showEditContact) {
                EditContactView(contact: contact)
            }
        }
    }
    
}

#Preview {
    ContactDetailView(contact: .exampleContact)
}
