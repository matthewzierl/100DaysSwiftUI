//
//  ContentView.swift
//  iExpense
//
//  Created by Matthew Zierl on 9/17/24.
//
import SwiftUI


struct ExpenseItem: Identifiable, Codable { // with 'identifiable' don't need 'id' in ForEach
    var name: String
    var type: String
    var amount: Double
    var id = UUID()
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet { // whenever items changed, triggers this closure
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init () {
        let jsonDecoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? jsonDecoder.decode([ExpenseItem].self, from: data) {
                items = decodedItems
            } else {
                fatalError("Could not decode expenses from data")
            }
        } else {
            items = [] // empty array
        }
    }
}


struct ContentView: View {
    
    @State private var expenses = Expenses() // 'State' just keeps it alive bc it is class
    @State private var isShowingAddExpense = false
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .font(item.amount < 10 ? .caption : item.amount < 100 ? .body : .title)
                                
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                Section("Other") {
                    ForEach(expenses.items) { item in
                        if item.type != "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .font(item.amount < 10 ? .caption : item.amount < 100 ? .body : .title)
                                
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    isShowingAddExpense.toggle()
                }
            }
            .sheet(isPresented: $isShowingAddExpense) {
                // show an AddView
                AddView(expenses: expenses)
            }
        }
        
    }
    
    
    func removeItems(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
    
}

#Preview {
    ContentView()
}
