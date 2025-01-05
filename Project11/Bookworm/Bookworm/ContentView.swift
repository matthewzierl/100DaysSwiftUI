//
//  ContentView.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/1/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    @State var showingAddBook = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) { // SwiftData objects already conform to identifiable
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundStyle(book.rating <= 1 ? .red : .black)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    EditButton() // toggles between edit mode for the list
                }
                
                ToolbarItem(placement: .topBarTrailing) { // ensure correct placement of button
                    Button("Add Book", systemImage: "plus") {
                        showingAddBook.toggle()
                    }
                }
            }
            .navigationTitle(Text("Bookworm"))
            .sheet(isPresented: $showingAddBook) {
                AddBookView()
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
        }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
            
            do {
                try modelContext.save()
            } catch {
                print("Could not save deletion: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}
