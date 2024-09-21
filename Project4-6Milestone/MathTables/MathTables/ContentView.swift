//
//  ContentView.swift
//  MathTables
//
//  Created by Matthew Zierl on 9/13/24.
//

import SwiftUI

enum TableOperator: String {
    case Addition = "+"
    case Subtraction = "-"
    case Multiplication = "*"
    case Division = "÷"
    case Random = "?" // for later
}

struct Question {
    let op1: Int
    let op2: Int
    let opSym: TableOperator
    var answer: Double
    let index: Int
}

@Observable class MonsterTableViewModel {
    
    let tableOperator: TableOperator
    let maxRange: Int
    let numQuestions: Int
    var currentQuestion = 0
    
    var allQuestions = [Question]()
    
    init(tableOperator: TableOperator, maxRange: Int, numQuestions: Int) {
        self.tableOperator = tableOperator
        self.maxRange = maxRange
        self.numQuestions = numQuestions
        createQuestionSet()
    }
    
    
    func createQuestionSet() {
        
        for index in 0 ..< numQuestions {
    
            var question: Question?
            
            switch tableOperator {
            case .Addition:
                
                let op1 = Int.random(in: 0 ... maxRange)
                let op2 = Int.random(in: 0 ... maxRange)
                
                question = Question(op1: op1, op2: op2, opSym: tableOperator, answer: Double(op1 + op2), index: index)
                
            case .Subtraction:
                
                let op1 = Int.random(in: 0 ... maxRange)
                let op2 = Int.random(in: 0 ... op1) // no negatives
                
                question = Question(op1: op1, op2: op2, opSym: tableOperator, answer: Double(op1 - op2), index: index)
                
            case .Multiplication:
                
                let op1 = Int.random(in: 0 ... maxRange)
                let op2 = Int.random(in: 0 ... maxRange)
                question = Question(op1: op1, op2: op2, opSym: tableOperator, answer: Double(op1 * op2), index: index)
                
            case .Division:
                let op1 = Int.random(in: 0 ... maxRange)
                let op2 = Int.random(in: 1 ... maxRange) // no divide by 0
                question = Question(op1: op1, op2: op2, opSym: tableOperator, answer: Double(op1 / op2), index: index)
            case .Random:
                // TODO: implement random
                break
            }
            
            if let question = question {
                allQuestions.append(question)
            }
        }
    }
}


struct ContentView: View {
    
    // for fields
    @State private var range: Int = 1
    @State private var numQuestions: Int = 5
    @State private var tableOperator: TableOperator = TableOperator.Addition
    
    // animation vars
    @State private var bodyTimer: Timer? = nil
    @State private var scaleTimer: Timer? = nil
    @State private var isBodyExpanding = true
    @State private var rotationBody: Double = 3
    @State private var isRotatingForward = false
    @State private var bodyScaleEffect: Double = 1.0
    @State private var leftEyeAnimation: Double = 0.0
    @State private var rightEyeAnimation: Double = 1.0
    @State private var mouthAnimation: Double = 1.0
    
    // path
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                LinearGradient(colors: [.white, .green], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Image("body_darkF")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .rotationEffect(.degrees(-90))
                        VStack {
                            HStack {
                                Image("eye_human_blue")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .rotationEffect(.degrees(leftEyeAnimation))
                                Image("eye_human_red")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .scaleEffect(CGSize(width: rightEyeAnimation, height: rightEyeAnimation))
                            }
                            .offset(y: 20)
                            Image("mouthD")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                                .scaleEffect(CGSize(width: mouthAnimation, height: mouthAnimation))
                        }
                    }
                    .rotation3DEffect(
                        .degrees(rotationBody), axis: (x: 0, y: 0, z: 1)
                    )
                    .scaleEffect(CGSize(width: bodyScaleEffect, height: bodyScaleEffect))
                    
                    
                    
                    
                    
                    
                    VStack(spacing: 0) {
                        Text("Operator")
                            .padding()
                            .frame(width: 300, height: 20, alignment: .leading)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .background(.white)
                        HStack {
                            Text(tableOperator.rawValue)
                                .foregroundStyle(.black)
                            Spacer()
                            Picker("Operator", selection: $tableOperator) {
                                Text("+")
                                    .tag(TableOperator.Addition)
                                Text("-")
                                    .tag(TableOperator.Subtraction)
                                Text("*")
                                    .tag(TableOperator.Multiplication)
                                Text("÷")
                                    .tag(TableOperator.Division)
                            }
                            .tint(.black)
                        }
                        .padding()
                        .frame(width: 300, height: 40)
                        .font(.subheadline)
                        .background(.white)
                        
                        Text("Range")
                            .padding()
                            .frame(width: 300, height: 20, alignment: .leading)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .background(.white)
                        HStack {
                            Text("0 - \(range)")
                                .foregroundStyle(.black)
                            Spacer()
                            Picker("Number Range", selection: $range) {
                                ForEach(1 ..< 13) { num in
                                    Text("\(num)").tag(num)
                                }
                            }
                            .tint(.black)
                        }
                        .padding()
                        .frame(width: 300, height: 40)
                        .font(.subheadline)
                        .background(.white)
                        
                        Text("Number of Questions")
                            .padding()
                            .frame(width: 300, height: 20, alignment: .leading)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .background(.white)
                        HStack {
                            Text("\(numQuestions) questions")
                                .foregroundStyle(.black)
                            Spacer()
                            Picker("Num Questions", selection: $numQuestions) {
                                Text("5").tag(5)
                                Text("10").tag(10)
                                Text("20").tag(20)
                            }
                            .pickerStyle(.segmented) // Segmented control for picker
                            .foregroundStyle(.black)
                        }
                        .padding()
                        .frame(width: 300, height: 40)
                        .font(.subheadline)
                        .background(.white)
                    }
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 30)))
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 4, y: 4)
                    
                    Button("Enter") {
                        navigationPath.append("firstQuestion")
                    }
                    .font(.headline)
                    .frame(width: 80, height: 40)
                    .background(.white)
                    .foregroundStyle(.black)
                    .clipShape(.capsule)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 4, y: 4)
                    
                }
            }
            .navigationTitle("MonsterTables")
            .navigationDestination(for: String.self) { value in
                if value == "firstQuestion" {
                    QuestionView(monsterTableViewModel: MonsterTableViewModel(tableOperator: tableOperator, maxRange: range, numQuestions: numQuestions), navigationPath: $navigationPath)
                }
            }
            .onChange(of: tableOperator) { oldValue, newValue in
                withAnimation(.spring(duration: 2, bounce: 0.6)) {
                    leftEyeAnimation -= 90
                }
            }
            .onChange(of: range) { oldValue, newValue in
                withAnimation(.spring(duration: 2, bounce: 0.9)) {
                    rightEyeAnimation = 100.0 / Double.random(in: 110 ... 130)
                }
            }
            .onAppear() {
                withAnimation(.bouncy(duration: 5, extraBounce: 0.2)) {
                    rotationBody = -3
                    isRotatingForward.toggle()
                }
                startBodyTimer()
            }
            .onDisappear() {
                stopBodyTimer()
            }
        }
    }
    
    func startBodyTimer() {
        bodyTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            withAnimation(.bouncy(duration: 5, extraBounce: 0.2)) {
                // rotationBody starts at -3
                rotationBody = isRotatingForward ? 3 : -3
                isRotatingForward.toggle()
                
            }
        })
        scaleTimer = Timer.scheduledTimer(withTimeInterval: 1.4, repeats: true, block: { _ in
            withAnimation(.spring) {
                bodyScaleEffect = isBodyExpanding ? 1.05 : 1.0
                mouthAnimation = isBodyExpanding ? 1.3 : 1.0
                isBodyExpanding.toggle()
            }
        })
    }
    
    func stopBodyTimer() {
        bodyTimer?.invalidate()
        scaleTimer?.invalidate()
        bodyTimer = nil
        scaleTimer = nil
    }
}

#Preview {
    ContentView()
}
