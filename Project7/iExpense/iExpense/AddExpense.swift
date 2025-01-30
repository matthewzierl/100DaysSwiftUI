//
//  AddView.swift
//  iExpense
//
//  Created by Matthew Zierl on 9/19/24.
//

import SwiftData
import SwiftUI

struct AddExpense: View {
    
    @State private var name: String = ""
    @State private var selectedCategory: ExpenseCategory?
    @State private var amount: Double = 0.0
    
    @State private var isShowingAlert: Bool = false
    @State private var createACategoryAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @Query(sort: \ExpenseCategory.categoryName) var expenseCategories: [ExpenseCategory]
        
    
    var body: some View {
        NavigationStack {
            Form {
                
                TextField("Expense Name", text: $name)
                
                Picker("Category", selection: $selectedCategory) {
                    ForEach(expenseCategories, id: \.self) { category in
                        Text(category.categoryName)
                            .tag(category) // have to return actually category
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
                
            }
            .onAppear {
                if expenseCategories.isEmpty {
                    createACategoryAlert = true
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Submit") {
                        addNewExpense()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(name.isEmpty ? "Untitled" : name)
            .alert("Please Fill In All Fields", isPresented: $isShowingAlert) {
                Button("Okay") { }
            }
            .alert("Please Create A Category First", isPresented: $createACategoryAlert) {
                Button("Okay") {
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
    
    func addNewExpense() {
        
        guard name != "" else {
            isShowingAlert.toggle()
            return
        }
        guard let selectedCategory = selectedCategory else {
            createACategoryAlert.toggle()
            return
        }
        
        let item = ExpenseItem(name: name, amount: amount, category: selectedCategory)
    
        selectedCategory.items.append(item)
        
        context.insert(item)
        
        dismiss()
        
    }
}

//#Preview {
//    AddView(expenses: Expenses())
//}
