//
//  ExpenseList.swift
//  iExpense
//
//  Created by Matthew Zierl on 1/8/25.
//

import SwiftUI

struct ExpenseItemView: View {
    
    var category: ExpenseCategory
    var maximumAmount: Double
    @Binding var itemSortOrder: [SortDescriptor<ExpenseItem>]
    
    private var filteredItems: [ExpenseItem] {
        category.items
            .filter { $0.amount <= maximumAmount } // Filter out min amount
            .sorted(using: itemSortOrder) // Sort in-memory
    }
    
    var body: some View {
        ForEach(filteredItems) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.category?.categoryName ?? "Unknown")
                }
                Spacer()
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(item.amount < 10 ? .caption : item.amount < 100 ? .body : .title)
            }
            .accessibilityElement()
            .accessibilityLabel("\(item.name), \(item.amountString)")
            .accessibilityHint(item.category?.categoryName ?? "Unknown Category")
        }
    }
    
    init(category: ExpenseCategory, maximumAmount: Double, itemSortOrder: Binding<[SortDescriptor<ExpenseItem>]>) {
        self.category = category
        self.maximumAmount = maximumAmount
        self._itemSortOrder = itemSortOrder
    }
}

//#Preview {
//    ExpenseList()
//}
