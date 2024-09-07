//
//  ContentView.swift
//  BetterRest
//
//  Created by Matthew Zierl on 9/6/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sleepAmount = 8.0
    @State private var now = Date.now
    
    var body: some View {
//        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
//        DatePicker("Please enter a date", selection: $now, in: Date.now..., displayedComponents: .hourAndMinute)
//            .labelsHidden() // hide label, and get rid of white space
        Text(Date.now, format: .dateTime.day().month().year())
    }
    
    func dateComponents() {
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minutes = components.minute ?? 0
    }
    
    func exampleDates() {
        let now = Date.now
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = now ... tomorrow
    }
    
}

#Preview {
    ContentView()
}
