//
//  ContentView.swift
//  Navigation
//
//  Created by Matthew Zierl on 9/27/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
            
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline) // if you make navigation title binding, can customize when navigation bar is .inline
        }
    }
}

//struct ContentView: View {
//    
//    var body: some View {
//        NavigationStack {
//            Text("world")
//            
//            .toolbar {
////                ToolbarItem(placement: .confirmationAction) { // wrap in ToolbarItem to customize
////                    Button("Tap me") {
////                        // button action
////                    }
////                }
//                
//                ToolbarItemGroup(placement: .topBarLeading) { // for multiple buttons at a time
//                    Button("Tap me") {}
//                    Button("help") {}
//                }
//            }
//        }
//        
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0 ..< 1000) { num in
//                Text("\(num)")
//            }
//            
//            .navigationTitle("Title")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(.blue)
//            .toolbarColorScheme(.dark)
////            .toolbar(.hidden)
//        }
//    }
//}

#Preview {
    ContentView()
}
