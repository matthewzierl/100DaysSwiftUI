//
//  Materials.swift
//  Moonshot
//
//  Created by Matthew Zierl on 9/22/24.
//

import SwiftUI

struct CustomText: View {
        
    let text: String
    
    var body: some View {
        Text(text)
    }
    
    init(text: String) {
        self.text = text
    }
}

struct Address: Codable {
    let street: String
    let city: String
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Materials: View {
    
    
    
    
    let layout = [
//        GridItem(.fixed(80)), // fixed points across
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
        GridItem(.adaptive(minimum: 80)) // as many col as possible, with min 80 points
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) { // HGRID
                ForEach(0 ..< 1000) {
                    Text("Item: \($0)")
                }
            }
        }
    }
    
    
    // LazyVGrid
//    let layout = [
////        GridItem(.fixed(80)), // fixed points across
////        GridItem(.fixed(80)),
////        GridItem(.fixed(80))
//        GridItem(.adaptive(minimum: 80)) // as many col as possible, with min 80 points
//    ]
//    
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: layout) { // VGRID
//                ForEach(0 ..< 1000) {
//                    Text("Item: \($0)")
//                }
//            }
//        }
//    }
    
    
    
    
    // decoding json using structs
//    var body: some View {
//        Button("Decode JSON") {
//            let input = """
//                {
//                    "name": "Taylor Swift",
//                    "address": {
//                        "street": "555, Taylor Swift Avenue",
//                        "city": "Nashville"
//                    }
//                }
//                """
//            
//            let data = Data(input.utf8)
//            let decoder = JSONDecoder()
//            
//            if let user = try? decoder.decode(User.self, from: data) {
//                print(user.address.street)
//            }
//        }
//    }
    
    
    
//    // Lists with navigation links
//    var body: some View {
//        NavigationStack {
//            
//            List(0 ..< 100) { row in
//                NavigationLink("Row: \(row)") {
//                    Text("Detail \(row)")
//                }
//            }
//            
//            .navigationTitle("SwiftUI")
//        }
//    }
    
    
    
    
    // Navigation Link Intro
//    var body: some View {
//        NavigationStack {
//            
//            NavigationLink {
//                Text("Detail View")
//            } label: {
//                VStack {
//                    Text("This is the label")
//                    Text("So is this")
//                    Image(systemName: "face.smiling")
//                }
//                .font(.largeTitle)
//            }
//            
//            .navigationTitle("SwiftUI")
//        }
//    }
    
    
    
//    // Lazy stacks, scroll view
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHStack(spacing: 10) { // LazyStack is like dequeueReusableCell where it only creats new rows dynamically and not all up front
//                ForEach(0 ..< 100) {
//                    CustomText(text: "Item: \($0)")
//                        .font(.title)
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
//    }
    
    
    
    
    
    // Aspect ratios and frame / containers
//    var body: some View {
//        VStack {
//            Image(.aot)
//                .resizable()
//                .scaledToFit() // fill until set of edges touch borders w/o stretching
////                .scaledToFill() // fill until all borders taken w/o stretching
//                .containerRelativeFrame(.horizontal) { size, axis in
//                    return 0.8 * size // get frame relative to size of parent
//                }
//        }
//    }
}


#Preview {
    Materials()
}
