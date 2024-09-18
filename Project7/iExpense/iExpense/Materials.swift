//
//  Materials.swift
//  iExpense
//
//  Created by Matthew Zierl on 9/18/24.
//

import Observation
import SwiftUI


struct User: Codable {
    let firstName: String
    let lastName: String
}

struct Materials: View {
    
    @State private var user = User(firstName: "Matthew", lastName: "Zierl")
    
    var body: some View {
        
        Button("Save User") {
            let jsonEncoder = JSONEncoder()
            
            if let data = try? jsonEncoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "user")
            }
        }
    }
}







//struct Materials: View {
//    
//    @AppStorage("tapCount") private var tapCount = 0 // automatically save/retrives from defaults
//    
//    var body: some View {
//        Button("Tap Count: \(tapCount)") {
//            tapCount += 1
//        }
//    }
//}


//struct Materials: View {
//    
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("Row: \($0)")
//                    }
//                    .onDelete(perform: removeRows) // only works on ForEach
//                }
//                
//                Button("Add Number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            
//            .toolbar {
//                EditButton()
//            }
//        }
//    }
//    
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
//    
//    
//}

//struct SecondView: View {
//    
//    @Environment(\.dismiss) var dismiss
//    
//    var message: String
//    
//    var body: some View {
//        Text("I'm the guy she told you not worry about")
//        Text("\(message)")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}
//
//struct Materials: View {
//    
//    @State private var showingSheet = false
//    
//    var body: some View {
//        
//        
//        ZStack {
//            
//            LinearGradient(colors: [.white, .mint], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//            
//            HStack {
//                Button("押します") {
//                    showingSheet.toggle()
//                }
//                .frame(width: 100, height: 40)
//                .background(.white)
//                .foregroundStyle(.cyan)
//                .clipShape(.capsule)
//                .shadow(radius: 5)
//            }
//        }
//        
//        .sheet(isPresented: $showingSheet) {
//            // content of our sheet
//            SecondView(message: "日本語を勉強してます！")
//        }
//    }
//}

#Preview {
    Materials()
}
