//
//  AddBookView.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/3/25.
//

import SwiftUI

struct AddBookView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = "Fantasy"
    @State private var review: String = ""
    @State private var rating: Int = 0
    
    @State private var emptyFields: Bool = false
        
    var genres: [String] = ["Fantasy", "Horror", "Poetry", "Romance", "Kids", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of Book", text: $title)
                    TextField("Author's Name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) { genre in
                            Text(genre)
                        }
                    }
                }
                Section("Write a Review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                Section {
                    Button("Save") {
                        if title.isEmpty || author.isEmpty || genre.isEmpty || review.isEmpty {
                            emptyFields = true
                            return
                        }
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        newBook.dateAdded = Date.now
                        modelContext.insert(newBook)
                        
                        do {
                            try modelContext.save()
                        } catch {
                            print("Could not save new book model to context: \(error)")
                        }
                        
                        dismiss()
                    }
                }
            }
            .navigationTitle(Text("Add Book"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .alert(isPresented: $emptyFields) {
                Alert(title: Text("Empty Fields"), message: Text("Please fill out all fields."))
            }
        }
    }
}

#Preview {
    AddBookView()
}
