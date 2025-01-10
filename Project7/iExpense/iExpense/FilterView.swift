//
//  FilterView.swift
//  iExpense
//
//  Created by Matthew Zierl on 1/9/25.
//

import SwiftData
import SwiftUI

struct FilterView: View {
    
    @Query(sort: \ExpenseCategory.categoryName) var expenseCategories: [ExpenseCategory]
    @Environment(\.modelContext) var context
    
    @Binding var categorySelection: [String]
    @Binding var amountMaximum: Double
    
    @State private var selectionSet = Set<ExpenseCategory>()
    
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            if expenseCategories.isEmpty {
                Text("No Categories to Choose From")
            } else {
                List(expenseCategories, id: \.self, selection: $selectionSet) { category in
                    Text(category.categoryName)
                }
            }
                        
            HStack {
                Slider(value: $amountMaximum, in: 0...1000, step: 1)
                Text("Maximum Amount: \(amountMaximum, specifier: "%.2f")")
            }
            
        }
        .toolbar {
            EditButton()
            Button("Apply Filters") {
                categorySelection = selectionSet.map { $0.categoryName }
                dismiss() // for now
            }
        }
        
    }
    
    
    init(categorySelection: Binding<[String]>, maximumAmount: Binding<Double>) {
        
        self._categorySelection = categorySelection
        self._amountMaximum = maximumAmount
    }
}

//#Preview {
//    FilterView()
//}
