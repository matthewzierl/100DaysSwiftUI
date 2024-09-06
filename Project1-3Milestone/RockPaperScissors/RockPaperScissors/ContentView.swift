//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Matthew Zierl on 9/5/24.
//

import SwiftUI

struct ContentView: View {
    
    enum Prediciton {
        case none, win, lose
    }
    
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
    
    let images = ["rock", "paper", "scissors"]
    @State private var currentChoice: String = ""
    @State private var npcChoice: String = ""
    @State private var result: String = ""
    @State private var showingChoice = false
    @State private var showingPrompt = false
    @State private var showingResults = false
    @State private var showFinalScore = false
    @State private var prediction: Prediciton = .none
    @State private var turn = 1
    @State private var score = 0
    
    var body: some View {
        
        
        NavigationStack {
            ZStack {
                
                LinearGradient(colors: [.pink, .blue], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Score: \(score)")
                        Spacer()
                        Text("Turn: \(turn)")
                        Spacer()
                    }
                    
                    Spacer()
                    Text("Your Prediction: \(getPredicition())")
                    Button {
                        showingChoice = true
                    } label: {
                        Text("Make Prediction")
                    }
                    .alert("Win or Lose?", isPresented: $showingChoice) {
                        Button("Win") {
                            prediction = .win
                        }
                        Button("Lose") {
                            prediction = .lose
                        }
                    } message: {
                        Text("Make your prediction before choosing.")
                    }

                    
                    Spacer()
                    
                    VStack {
                        ForEach(images, id: \.self) { image in
                            Button(action: {
                                submitChoice(choice: image)
                            }, label: {
                                ImageView(imageName: image)
                            })
                            
                        }
                    }
                    
                    Spacer()
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        startNewGame()
                    }) {
                        Image(systemName: "repeat")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .alert("Please Make a Prediction First", isPresented: $showingPrompt) {
            Button("Okay") { }
        }
        .alert("Results", isPresented: $showingResults) {
            Button("Okay") { startNextTurn() }
        } message: {
            Text("Your Prediction: \(getPredicition())\nYour Move: \(currentChoice) | NPC Move: \(npcChoice)\nYou were \(result)!")
        }
        .alert("Game Over", isPresented: $showFinalScore) {
            Button("New Game") {
                startNewGame()
            }
        } message: {
            Text("Final Score: \(score)")
        }
    }
    
    func getPredicition() -> String {
        switch prediction {
        case .none:
            return "none"
        case .win:
            return "win"
        case .lose:
            return "lose"
        }
    }
    
    func submitChoice(choice: String) {
        
        guard prediction != .none else {
            showingPrompt = true
            return
        }
        
        currentChoice = choice
        
        npcChoice = images[Int.random(in: 0..<3)]
        
        switch currentChoice {
        case "rock":
            if prediction == .win {
                if npcChoice == "scissors" {
                    score += 1
                    result = "Correct"
                } else {
                    result = "Wrong"
                }
            } else { // lose
                if npcChoice == "paper" {
                    score += 1
                    result = "Correct"
                } else {
                    result = "Wrong"
                }
            }
        case "paper":
            if prediction == .win {
                if npcChoice == "rock" {
                    score += 1
                    result = "Correct"
                } else {
                    result = "Wrong"
                }
            } else { // lose
                if npcChoice == "scissors" {
                    score += 1
                    result = "Correct"
                } else {
                    result = "Wrong"
                }
            }
        case "scissors":
            if prediction == .win {
                if npcChoice == "paper" {
                    score += 1
                    result = "Correct"
                } else {
                    result = "Wrong"
                }
            } else { // lose
                if npcChoice == "rock" {
                    score += 1
                    result = "Correct"
                } else {
                    result = "Wrong"
                }
            }
            
        default:
            break
        }
        
        showingResults = true
    }
    
    func startNextTurn() {
        turn += 1
        prediction = .none
        if turn > 10 {
            showFinalScore = true
        }
    }
    
    func startNewGame() {
        turn = 1
        score = 0
    }
}

#Preview {
    ContentView()
}
