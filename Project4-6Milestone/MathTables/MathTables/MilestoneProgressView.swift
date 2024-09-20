//
//  MilestoneProgressView.swift
//  MathTables
//
//  Created by Matthew Zierl on 9/19/24.
//

import SwiftUI


struct MilestoneProgressView: View {
    
    @State var count: Float
    @State private var radius: CGFloat = 6
    @State private var lineWidth: CGFloat = 3
    @State var progress: CGFloat
    
    var body: some View {
        GeometryReader { bounds in
            VStack(spacing: 70) {
                MilestoneShape(count: Int(count), radius: radius)
                    .stroke(lineWidth: lineWidth)
                    .foregroundColor(.indigo.opacity(0.3))
                    .padding(.horizontal, lineWidth/2)
                    .frame(height: 100)
                    .overlay {
                        MilestoneShape(count: Int(count), radius: radius)
                            .stroke(lineWidth: lineWidth)
                            .foregroundColor(.indigo)
                            .padding(.horizontal, lineWidth/2)
                            .mask(
                                HStack {
                                    Rectangle()
                                        .frame(width: bounds.size.width * progress, alignment: .leading)
                                        .blur(radius: 2)
                                    Spacer(minLength: 0)
                                }
                            )
                    }
                    .padding(.horizontal, lineWidth/2)
//                    .background(.red)
                
//                controls
            }
        }
//        .padding()
    }
    
//    @ViewBuilder private var controls: some View {
//        VStack(spacing: 30) {
//            VStack(alignment: .leading) {
//                Slider(value: $progress, in: 0...1)
//                Text("Progress")
//            }
//            
//            VStack(alignment: .leading) {
//                Slider(value: $count, in: 3...7)
//                Text("Count")
//            }
//            
//            VStack(alignment: .leading) {
//                Slider(value: $radius, in: 5...25)
//                Text("Radius")
//            }
//            
//            VStack(alignment: .leading) {
//                Slider(value: $lineWidth, in: 2...30)
//                Text("Line Width")
//            }
//        }
//    }
    
    struct MilestoneShape: Shape {
        let count: Int
        let radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            path.move(to: CGPoint(x: 0, y: rect.midY))
            
            var maxX: CGFloat = 0
            let remainingSpace: CGFloat = rect.width - (CGFloat(count)*radius*2) // Circle space
            let lineLength: CGFloat = remainingSpace / CGFloat(count - 1) // Remaining line space
            
            for i in 1...count {
                path.addEllipse(in: CGRect(origin: CGPoint(x: maxX, y: rect.midY - radius), size: CGSize(width: radius*2, height: radius*2)))
                maxX += radius*2
                path.move(to: CGPoint(x: maxX, y: rect.midY))
                if i != count {
                    maxX += lineLength
                    path.addLine(to: CGPoint(x: maxX, y: rect.midY))
                }
            }
            
            return path
        }
    }
}

#Preview {
    MilestoneProgressView(count: 10, progress: 0.5)
}
