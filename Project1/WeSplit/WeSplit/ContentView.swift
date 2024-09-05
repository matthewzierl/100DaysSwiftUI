//
//  ContentView.swift
//  WeSplit
//
//  Created by Matthew Zierl on 8/31/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    private var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection / 100)
        let total = checkAmount + tipValue
        return total
    }
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate total per person here
        let peopleCount = Double(numPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipSelection / 100)
        let total = checkAmount + tipValue
        let amountPerPerson = total / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View { // returns a view
        NavigationStack {
            Form {
                Section {
                    TextField("Amount: ", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused) // changes amountIsFocused if focused
                    
                    Picker("People: ", selection: $numPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage: ", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total Amount") {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                
                Section("Amount Per Person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
