//
//  ContentView.swift
//  iFace
//
//  Created by Matthew Zierl on 2/1/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var allContacts: [Contact]
    @State private var showAddContactSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List() {
                ForEach(allContacts) { contact in
                    
                    NavigationLink(destination: ContactDetailView(contact: contact)) {
                        HStack {
                            if let photo = contact.photo {
                                photo
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Image(.defaultpfp)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            Text("\(contact.firstName) \(contact.lastName)")
                        }
                    }
                
                }
                .onDelete(perform: delete)
            }
            
            
            
            .toolbar {
                Button("Add Contact", systemImage: "plus") {
                    showAddContactSheet.toggle()
                }
            }
            .sheet(isPresented: $showAddContactSheet) { AddContactView() }
            .navigationTitle("iFace")
        }
    }
    
    func delete(at offsets: IndexSet) {
        
//        let deletedContact =
//        modelContext.delete(allContacts[offsets.first!])
    }
}

#Preview {
    ContentView()
}
