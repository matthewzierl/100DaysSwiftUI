//
//  ContentView.swift
//  BetterRest
//
//  Created by Matthew Zierl on 9/6/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeup = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false

    
    static var defaultWakeTime: Date { // make static to be used by other vars
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Recommended Time") {
                    Text("\(calculateBedtime())")
                        .font(.largeTitle)
                }
                Section("When Do You Want to Wake Up?") {
                    DatePicker("Please Enter a Time", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Section("Desired Amount of Sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                Section("Daily Cups of Coffee") {
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(0 ..< 13) { number in
                            Button("\(number)") {
                                coffeeAmount = number + 1
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button {
//                    calculateBedtime()
//                } label: {
//                    Text("Calculate")
//                }
//            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Ok") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hours = (components.hour ?? 0) * 60 * 60 // convert to sec
            let minutes = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount)) // in seconds
            
            let sleepTime = wakeup - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            showAlert = true
        }
        return ""
    }
    
}

#Preview {
    ContentView()
}
