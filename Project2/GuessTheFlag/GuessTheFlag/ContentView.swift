//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Matthew Zierl on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    
    struct CountryImage: View {
        var flag: Image
        
        var body: some View {
            flag
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
    }
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2) // 3 flags presented, 1 correct
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var numTurns = 0
    @State private var showingEndGame = false
    
    @State private var animationAmounts = [Double](repeating: 0, count: 3) // 3 flags
    @State private var shouldFade = [Bool](repeating: false, count: 3)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0 ..< 3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                            withAnimation(.bouncy(duration: 1.5)) {
                                animationAmounts[number] += 360
                                for index in 0..<3 {
                                    shouldFade[index] = index != number
                                }

                            }
                        } label: {
                            CountryImage(flag: Image(countries[number]))
                        }
                        .rotation3DEffect(
                            .degrees(animationAmounts[number]), axis: (x: 0, y: 1, z: 0)
                        )
                        .opacity(shouldFade[number] ? 0.25 : 1.0)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game End", isPresented: $showingEndGame) {
            Button("Continue") {
                score = 0
                numTurns = 0
                askQuestion()
            }
        } message: {
            Text("8 turns are over\nYou ended with a score of \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        numTurns += 1
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            scoreMessage = "Your Score: \(score)"
        } else {
            scoreTitle = "Wrong."
            scoreMessage = "You selected \(countries[number])\nScore: \(score)"
        }
        showingScore = true
        if numTurns >= 8 {
            showingEndGame = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ..< 2)
        withAnimation {
            for (index, bool) in shouldFade.enumerated() {
                shouldFade[index] = false
            }
        }
    }
}

#Preview {
    ContentView()
}
