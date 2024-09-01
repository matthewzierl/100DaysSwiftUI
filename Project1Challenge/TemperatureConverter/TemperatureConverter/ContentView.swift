//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Matthew Zierl on 9/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var originalUnit = "Fahrenheit"
    @State private var desiredUnit = "Fahrenheit"
    @State private var numOriginalUnits = 0.0
    @FocusState private var tempFieldIsFocused
    private var finalTemp: Double {
        if originalUnit == "Fahrenheit" {
            switch desiredUnit {
            case "Fahrenheit":
                return numOriginalUnits
            case "Celsius":
                return (numOriginalUnits - 32) * 5/9
            case "Kelvin":
                return (numOriginalUnits - 32) * 5/9 + 273.15
            default:
                fatalError()
            }
        } else if originalUnit == "Celsius" {
            switch desiredUnit {
            case "Fahrenheit":
                return (numOriginalUnits * 9/5) + 32
            case "Celsius":
                return numOriginalUnits
            case "Kelvin":
                return numOriginalUnits + 273.15
            default:
                fatalError()
            }
        } else { // Kelvin
            switch desiredUnit {
            case "Fahrenheit":
                return (numOriginalUnits - 273.15) * 9/5 + 32
            case "Celsius":
                return numOriginalUnits - 273.15
            case "Kelvin":
                return numOriginalUnits
            default:
                fatalError()
            }
        }
    }
    
    let availableUnits = ["Fahrenheit", "Celsius", "Kelvin"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Original") {
                    HStack {
                        TextField("Number of Units", value: $numOriginalUnits, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($tempFieldIsFocused)
                        Picker("", selection: $originalUnit) {
                            ForEach(availableUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Section("Desired") {
                    HStack {
                        Text("\(finalTemp)")
                        Picker("", selection: $desiredUnit) {
                            ForEach(availableUnits, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                }
            }
            .navigationTitle("Temperature Converter")
            .toolbar {
                if tempFieldIsFocused {
                    Button("Done") {
                        tempFieldIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
