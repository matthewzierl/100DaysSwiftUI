//
//  DetailView.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/3/25.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    
    var book: Book
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var deleteConfirmation: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFill()
                    
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            Text(book.review)
                .padding()
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            if let date = book.dateAdded {
                Text((date.formatted()))
                    .padding()
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Delete this book", systemImage: "trash") {
                    deleteConfirmation = true
                }
            }
        }
        .alert("Delete Book", isPresented: $deleteConfirmation) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        
    }
    
    func deleteBook() {
        modelContext.delete(book)
        do {
            try modelContext.save()
        } catch {
            print("Could not delete book: \(error.localizedDescription)")
        }
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "This review is only for testing purposes. It is not intended to be a review of any book.", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to load preview: \(error.localizedDescription)")
    }
}
