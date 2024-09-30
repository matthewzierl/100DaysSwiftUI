//
//  AddView.swift
//  iExpense
//
//  Created by Matthew Zierl on 9/19/24.
//

import SwiftUI

struct AddView: View {
    
    @State private var name: String = "Untitled"
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    @State private var isShowingAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("\(type)", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text("\(type)")
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    
            }
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction){
                    Button("Submit") {
                        guard name != "" else {
                            isShowingAlert.toggle()
                            return
                        }
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle($name)
            .alert("Please Fill In All Fields", isPresented: $isShowingAlert) {
                Button("Okay") { }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
