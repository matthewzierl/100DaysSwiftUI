//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Matthew Zierl on 1/7/25.
//

import SwiftData
import Foundation

@Model
class ExpenseItem { // with 'identifiable' don't need 'id' in ForEach
    
    var name: String
    var category: ExpenseCategory?
    var amount: Double
    var amountString: String {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        if let amount = formatter.string(from: NSNumber(value: amount)) {
            return amount
        } else {
            return "Could not convert amount"
        }
    }
    
    init(name: String, amount: Double, category: ExpenseCategory? = nil) {
        self.name = name
        self.amount = amount
        self.category = category
    }
}
