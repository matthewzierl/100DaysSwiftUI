//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matthew Zierl on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    
    struct ImageView: View {
        
        var imageName: String
        
        var body: some View {
            Image(imageName)
                .resizable()
                .frame(maxWidth: 300, maxHeight: 140)
                .clipShape(.capsule)
                .shadow(radius: 10)
                .padding(5)
        }
    }
    
    var body: some View {
        
        let images = ["rock", "paper", "scissors"]
        
        NavigationStack {
            ZStack {
                
                LinearGradient(colors: [.pink, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("Score: 0")
                        Spacer()
                        Text("Rock Paper Scissors")
                        Spacer()
                        Text("Turn: 0")
                    }
                    
                    Spacer()
                    
                    VStack {
                        ForEach(images, id: \.self) { image in
                            
                            Button(action: {
                                submitChoice()
                            }, label: {
                                ImageView(imageName: image)
                            })
                            
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .navigationTitle("TLSKJF:LJDLF")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Button pressed!")
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func submitChoice() {
        
    }
}

#Preview {
    ContentView()
}
