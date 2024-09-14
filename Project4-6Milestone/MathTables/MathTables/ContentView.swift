//
//  ContentView.swift
//  MathTables
//
//  Created by Matthew Zierl on 9/13/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var sample: String = ""
    @State private var difficulty: Int = 1
    @State private var numQuestions: Int = 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, .green], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                Picker("Number of Questions", selection: $difficulty) {
                    ForEach(1 ..< 20) { num in
                        Button("\(num)") { }
                    }
                }
                
                Button( action: {
                    
                }, label: {
                    Text("Enter")
                        .font(.headline)
                        .frame(width: 80, height: 30)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 4, y: 4)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
