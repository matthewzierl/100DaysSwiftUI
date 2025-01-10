//
//  ExpenseListView.swift
//  iExpense
//
//  Created by Matthew Zierl on 1/8/25.
//

import SwiftData
import SwiftUI

struct ExpenseListView: View {
    
    @Query(sort: \ExpenseCategory.categoryName) var expenseCategories: [ExpenseCategory]
    
    var maximumAmount: Double
    @Binding var itemSortOrder: [SortDescriptor<ExpenseItem>]
    
    var body: some View {
        List {
            ForEach(expenseCategories) { category in
                Section(category.categoryName) {
                    ExpenseItemView(category: category, maximumAmount: maximumAmount, itemSortOrder: $itemSortOrder)
                }
            }
        }
    }
    
    init(filterCategory: [String], maximumAmount: Double, categorySortOrder: [SortDescriptor<ExpenseCategory>], itemSortOrder: Binding<[SortDescriptor<ExpenseItem>]>) {
        
        _expenseCategories = Query(filter: #Predicate<ExpenseCategory> { category in
            if filterCategory.contains(category.categoryName) {
                return true
            } else {
                return false
            }
        }, sort: categorySortOrder)
        
        self.maximumAmount = maximumAmount
        self._itemSortOrder = itemSortOrder
        
    }
}

//#Preview {
//    ExpenseListView()
//}
