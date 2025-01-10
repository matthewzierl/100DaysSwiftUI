//
//  Expense.swift
//  iExpense
//
//  Created by Matthew Zierl on 1/7/25.
//
import SwiftData
import Foundation

@Model
class ExpenseCategory {
    
    @Relationship(deleteRule: .cascade) var items = [ExpenseItem]()
    var categoryName: String
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}
