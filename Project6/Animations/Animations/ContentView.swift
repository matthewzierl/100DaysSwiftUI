//
//  ContentView.swift
//  Animations
//
//  Created by Matthew Zierl on 9/10/24.
//

import SwiftUI


struct CornerRotateViewModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateViewModifier(amount: -90, anchor: .topLeading), identity: CornerRotateViewModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.red)
                .frame(width: 200, height: 300)
            
            if isShowingRed {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 300)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
    
    
    
    
    
    
    
    // View transitions
//    @State private var isShowingRed = false
//    
//    var body: some View {
//        VStack {
//            Button("Tap Me") {
//                withAnimation {
//                    isShowingRed.toggle()
//                }
//            }
//            
//            if isShowingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .animation(.bouncy, value: isShowingRed)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity)) // specify transition type
//            }
//        }
//    }
    






    
//    @State private var animationAmount = 0.0
    
//    let letters = Array("I MISS TOKYO")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//    
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0 ..< letters.count, id: \.self) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
//                    .gesture(
//                        DragGesture()
//                            .onChanged({ drag in
//                                dragAmount = drag.translation
//                            })
//                            .onEnded({ drag in
//                                dragAmount = .zero
//                                enabled.toggle()
//                            })
//                    )
//            }
//        }
    
    
    
    
    
    
    
    
    
    
    
    
//    @State private var dragAmount = CGSize.zero
//    
//    
//    var body: some View {
//        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(.rect(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged({ action in
//                        dragAmount = action.translation
//                    })
//                    .onEnded({ action in
//                        dragAmount = .zero
//                    })
//            )
//            .animation(.spring(duration: 1, bounce: 0.7), value: dragAmount)
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    // Controlling animation stack
//    @State private var enabled = false
//    
//    
//    
//    var body: some View {
//        Button("Tap Me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .red : .blue)
//        .foregroundStyle(.white)
//        .animation(nil, value: enabled) // 'nil' = don't provide animation for above
//        .clipShape(.rect(cornerRadius: enabled ? 60 : 0)) // order matters
//        .animation(.spring(duration: 1, bounce: 0.9), value: enabled)
//    }
    
    
    
//    // Explicit animation
//    
//    var body: some View {
//        Button("Tap Me") {
//            withAnimation(.spring(duration: 1, bounce: 0.5)) {
//                animationAmount += 360
//            }
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundStyle(.white)
//        .clipShape(.circle)
//        .rotation3DEffect(
//            .degrees(animationAmount), axis: (x: 0, y: 1, z: 0)
//        )
//    }
    
    
    
    
    
    
    // binding animation
    
//    var body: some View {
//        
//        print(animationAmount)
    
//        return VStack {
//            Stepper("Scale Amount", value: $animationAmount.animation(.easeInOut(duration: 1).repeatCount(3, autoreverses: true)), in: 1...10) // '.animation()' makes change in value have animation for whatever effect is tied to that value
//            
//            Spacer()
//            
//            Button("Tap Me") {
//                animationAmount += 1.0
//            }
//            .padding(40)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(.circle)
//            .scaleEffect(animationAmount)
//        }
//    }
    
    
    
    
    
    
    // normal animation
    
//    var body: some View {
//        Button("Tap Me") {
////            animationAmount += 1
//        }
//            .padding(50)
//            .background(.red)
//            .foregroundStyle(.white)
//            .clipShape(.circle)
////            .scaleEffect(animationAmount)
////            .blur(radius: (animationAmount - 1) * 3)
//            .overlay {
//                Circle()
//                    .stroke(.red)
//                    .scaleEffect(animationAmount)
//                    .opacity(2 - animationAmount)
//                    .animation(
//                        .easeOut(duration: 1)
//                            .repeatForever(autoreverses: false),
//                        value: animationAmount)
//            }
//            .onAppear(perform: {
//                animationAmount = 2
//            })
//    }
}

#Preview {
    ContentView()
}
