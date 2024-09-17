//
//  QuestionView.swift
//  MathTables
//
//  Created by Matthew Zierl on 9/15/24.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    
    var questionOperator: String
    var range: Int // top of range, starting from
    var index: Int
    var totalQuestions: Int
    var allBodies = ["body_darkF", "body_yellowF", "body_greenF", "body_redF", "body_blueF"]
    var allEyes = ["eye_yellow", "eye_red", "eye_human", "eye_human_red", "eye_human_green", "eye_human_blue", "eye_cute_light"]
    var allMouths = ["mouthA", "mouthB", "mouthC", "mouthD", "mouthE", "mouthF", "mouthG", "mouthH", "mouthI", "mouthJ"]
    
    @State private var op1: Int = 0
    @State private var op2: Int = 0
    @State private var answer: Double = 0
    @State private var opSym: String = "+"
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.white, Color(red: Double.random(in: 0 ... 1), green: Double.random(in: 0 ... 1), blue: Double.random(in: 0 ... 1))], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                ZStack {
                    Image(allBodies.randomElement()!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .rotationEffect(.degrees(-90))
                    VStack {
                        HStack {
                            Image(allEyes.randomElement()!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
//                                .rotationEffect(.degrees(leftEyeAnimation))
                            Image(allEyes.randomElement()!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
//                                .scaleEffect(CGSize(width: rightEyeAnimation, height: rightEyeAnimation))
                        }
                        .offset(y: 20)
                        Image(allMouths.randomElement()!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
//                            .scaleEffect(CGSize(width: mouthAnimation, height: mouthAnimation))
                    }
                }
//                .rotation3DEffect(
//                    .degrees(rotationBody), axis: (x: 0, y: 0, z: 1)
//                )
//                .scaleEffect(CGSize(width: bodyScaleEffect, height: bodyScaleEffect))
                
                
                Text("\(op1) \(opSym) \(op2)")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Answer: \(answer.formatted())")
            }
        }
        .onAppear(perform: {
            generateQuestion()
        })
            
    }
    
    func generateQuestion() {
        switch questionOperator {
        case "Addition":
            op1 = Int.random(in: 0 ... range)
            op2 = Int.random(in: 0 ... range)
            answer = Double(op1 + op2)
            opSym = "+"
        case "Subtraction":
            op1 = Int.random(in: 1 ... range) // ensure non-negative
            op2 = Int.random(in: 0 ... op1) // second operand is <= first
            answer = Double(op1 - op2)
            opSym = "-"
        case "Multiplication":
            op1 = Int.random(in: 0 ... range)
            op2 = Int.random(in: 0 ... range)
            answer = Double(op1 * op2)
            opSym = "*"
        case "Division":
            op1 = Int.random(in: 0 ... range)
            op2 = Int.random(in: 1 ... range) // can't be zero
            answer = Double(op1) / Double(op2)
            opSym = "÷"
        default:
            fatalError("Could not decipher question operator")
        }
    }
}

#Preview {
    QuestionView(questionOperator: "Multiplication", range: 10, index: 0, totalQuestions: 5)
}
