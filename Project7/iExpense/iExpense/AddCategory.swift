//
//  AddExpense.swift
//  iExpense
//
//  Created by Matthew Zierl on 1/7/25.
//

import SwiftUI

struct AddCategory: View {
    
    @Environment(\.modelContext) var context
    @State private var newCategoryName: String = ""
    @State private var missingFieldAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Category Name", text: $newCategoryName)
            }
            .navigationTitle("Add New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Submit") {
                        
                        // ensure user filled out fields
                        if newCategoryName.isEmpty {
                            missingFieldAlert = true
                            return
                        }
                        
                        // Create new category and add to list
                        let newCategory = ExpenseCategory(categoryName: newCategoryName)
                        context.insert(newCategory)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    AddCategory()
//}
