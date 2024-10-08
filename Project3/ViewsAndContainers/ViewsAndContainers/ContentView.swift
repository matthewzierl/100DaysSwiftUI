//
//  ContentView.swift
//  ViewsAndContainers
//
//  Created by Matthew Zierl on 9/4/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
        
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct WaterMark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func waterMarked(with text: String) -> some View {
        modifier(WaterMark(text: text))
    }
}

struct BigBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func makeBig() -> some View {
        modifier(BigBlueFont())
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Text("Hellow!")
        }
        .makeBig()
    }
}

#Preview {
    ContentView()
}
