//
//  QuestionView.swift
//  MathTables
//
//  Created by Matthew Zierl on 9/15/24.
//

import SwiftUI

struct RandomMonster: View {
    
    var allBodies = ["body_darkF", "body_yellowF", "body_greenF", "body_redF", "body_blueF"]
    var allEyes = ["eye_yellow", "eye_red", "eye_human", "eye_human_red", "eye_human_green", "eye_human_blue", "eye_cute_light"]
    var allMouths = ["mouthA", "mouthB", "mouthC", "mouthD", "mouthE", "mouthF", "mouthG", "mouthH", "mouthI", "mouthJ"]
    
    var body: some View {
        ZStack {
            Image(allBodies.randomElement()!)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(-90))
            
            VStack {
                HStack {
                    Image(allEyes.randomElement()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    Image(allEyes.randomElement()!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                .offset(y: 20)
                Image(allMouths.randomElement()!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
        }
    }
}


struct QuestionView: View {
    
    @ObservedObject var monsterTableViewModel: MonsterTableViewModel
    
    @Binding var navigationPath: NavigationPath
    
    let randColor = Color(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1))
    
    @State private var response: Double?
    
    @State private var isCorrect = false
    @State private var showCheckMark = false
    @State private var showXMark = false
    @State private var allQuestionsAnswered = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, randColor], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                MilestoneProgressView(count: Float(monsterTableViewModel.numQuestions), progress: CGFloat(Double(monsterTableViewModel.currentQuestion) / Double(monsterTableViewModel.numQuestions)))
                    .frame(height: 100)
                    .padding(EdgeInsets(top: 80, leading: 5, bottom: 0, trailing: 5))
                    .clipShape(.rect)
                
                RandomMonster()
                
                Text("\(monsterTableViewModel.allQuestions[monsterTableViewModel.currentQuestion].op1) \(monsterTableViewModel.allQuestions[monsterTableViewModel.currentQuestion].opSym.rawValue) \(monsterTableViewModel.allQuestions[monsterTableViewModel.currentQuestion].op2)")
                    .font(.largeTitle)
                
                HStack {
                    TextField("Answer...", value: $response, format: .number)
                        .font(.headline)
                        .frame(width: 80, height: 35)
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.buttonBorder)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 4, y: 4)
                        .keyboardType(.decimalPad)
                    
                    Button("Submit") {
                        guard let response = response else { return }
                        
                        if response == monsterTableViewModel.allQuestions[monsterTableViewModel.currentQuestion].answer {
                            isCorrect = true
                            withAnimation { showCheckMark = true }
                        } else {
                            isCorrect = false
                            withAnimation { showXMark = true }
                        }
                        
                        // Delay to show animation before moving to the next question
                        if monsterTableViewModel.currentQuestion == monsterTableViewModel.numQuestions - 1 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                allQuestionsAnswered = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                // increment and show another question
                                monsterTableViewModel.currentQuestion += 1
                                navigationPath.append(monsterTableViewModel.allQuestions[monsterTableViewModel.currentQuestion])
                            }
                        }
                    }
                    .font(.headline)
                    .frame(width: 80, height: 35)
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.buttonBorder)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 4, y: 4)
                }
                
                Spacer()
            }
            
            if showCheckMark {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 200))
                    .foregroundColor(.green)
                    .offset(y: -80)
                    .transition(.scale)
            } else if showXMark {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 200))
                    .foregroundColor(.red)
                    .offset(y: -80)
                    .transition(.scale)
            }
                
            }
        
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Home", systemImage: "house") {
                    // go back to main
                    navigationPath.removeLast(navigationPath.count) // Pops back to root
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Hide Keyboard", systemImage: "keyboard") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
        .ignoresSafeArea()
//        .navigationDestination(for: Question.self) { question in
//            QuestionView(monsterTableViewModel: monsterTableViewModel, navigationPath: $navigationPath)
//        }
    }
    //        .navigationDestination(isPresented: $showAnotherQuestion) {
    //            QuestionView(questionOperator: questionOperator, range: range, index: index + 1, totalQuestions: totalQuestions)
    //        }
    //        .navigationDestination(isPresented: $allQuestionsAnswered) {
    //            CompletionView()
    //        }
}


struct CompletionView: View {
    var body: some View {
        Text("All questions answered!")
            .font(.largeTitle)
            .padding()
    }
}
//
#Preview {
    QuestionView(monsterTableViewModel: MonsterTableViewModel(tableOperator: TableOperator.Multiplication, maxRange: 12, numQuestions: 5), navigationPath: .constant(NavigationPath()))
}
