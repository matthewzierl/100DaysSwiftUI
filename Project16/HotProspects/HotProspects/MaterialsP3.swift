//
//  MaterialsP3.swift
//  HotProspects
//
//  Created by Matthew Zierl on 2/5/25.
//

import SwiftUI

struct MaterialsP3: View {
    
    @State private var output: String = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
    func fetchReadings() async {
        
//        do {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            output = "Found \(readings.count) readings"
//        } catch {
//            print("Could not fetch readings: \(error.localizedDescription)")
//        }
        
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result // no 'try' because result holds the error
        
//        do {
//            output = try result.get()
//        } catch {
//            output = "Error: \(error.localizedDescription)"
//        }
        
        // Both above 👆 and below 👇 functionally the same
        
        switch result {
        case .success(let value):
            output = value
        case .failure(let error):
            output = error.localizedDescription
        }
        
        
        
    }
}

#Preview {
    MaterialsP3()
}
