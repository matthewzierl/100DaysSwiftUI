//
//  ContentView.swift
//  iExpense
//
//  Created by Matthew Zierl on 9/17/24.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    
    @Environment(\.modelContext) var context
    
    @State private var isShowingAddExpense = false
    
    @State private var categorySortOrder = [
        SortDescriptor(\ExpenseCategory.categoryName)
    ]
    
    @State private var itemSortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var categoryFilter = ["Food"]
    @State private var amountMaximum: Double = 10000
    
    @Query(sort: \ExpenseCategory.categoryName) var expenseCategories: [ExpenseCategory]
    
    
    var body: some View {
        NavigationStack {
            ExpenseListView(filterCategory: categoryFilter, maximumAmount: amountMaximum, categorySortOrder: categorySortOrder, itemSortOrder: $itemSortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                Button("Clear") {
                    do {
                        let allCategories = try context.fetch(FetchDescriptor<ExpenseCategory>())
                        for category in allCategories {
                            context.delete(category)
                        }
                    } catch {
                        print("Could not delete models: \(error)")
                    }
                }
                NavigationLink {
                    FilterView(categorySelection: $categoryFilter, maximumAmount: $amountMaximum)
                } label: {
                    Text("Filter")
                }
                
                Menu("Sort by", systemImage: "arrow.up.arrow.down") {
                    Menu("Category") {
                        Button("Name") {
                            categorySortOrder = [SortDescriptor(\ExpenseCategory.categoryName)]
                        }
                    }
                    Menu("Item") {
                        Button("Name") {
                            itemSortOrder = [SortDescriptor(\ExpenseItem.name), SortDescriptor(\ExpenseItem.amount)]
                        }
                        Button("Amount") {
                            itemSortOrder = [SortDescriptor(\ExpenseItem.amount),
                                             SortDescriptor(\ExpenseItem.name)]
                        }
                    }
                }
                Menu("Create New") {
                    
                    // Add Expense
                    NavigationLink {
                        AddExpense()
                    } label: {
                        Text("Expense")
                    }
                    
                    // Add Category
                    NavigationLink {
                        AddCategory()
                    } label: {
                        Text("Category")
                    }
                }

            }
//            .sheet(isPresented: $isShowingAddExpense) {
//                // show an AddView
//                AddView(expenses: expenses)
//            }
        }
        
    }
    
    
//    func removeItems(at offset: IndexSet) {
//        expenses.items.remove(atOffsets: offset)
//    }
    
}

#Preview {
    ContentView()
}
