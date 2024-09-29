//
//  Materials.swift
//  Navigation
//
//  Created by Matthew Zierl on 9/27/24.
//

import SwiftUI

struct Student: Hashable {
    var id = UUID()
    var name: String
    var age: Int
    
    init(id: UUID = UUID(), name: String, age: Int) {
        print("Creating student with name: \(name)")
        self.id = id
        self.name = name
        self.age = age
    }
}

//struct DetailView: View {
//    
//    var number: Int
//    
//    var body: some View {
//        Text("Detail View \(number)")
//    }
//    
//    init(number: Int) {
//        print("Creating detail view with number: \(number)")
//        self.number = number
//    }
//}

struct DetailView2: View {
    
    var number: Int
    @Binding var path: NavigationPath // shared object 'Binding'
    
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1 ... 1000))
        
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home", systemImage: "house") {
                    path = NavigationPath()
                }
            }
    }
}

@Observable
class PathStore {
    
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavePath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) { // must use codable representation of navigation path
                path = NavigationPath(decoded) // Initialize using NavigationPath
                return
            }
        }
        
        path = NavigationPath() // didn't find anything
    }
    
    func save() {
        
        guard let representation = path.codable else { // must use a codable representation of NavigationPath
            return
        }
        
        do {
            let data = try? JSONEncoder().encode(representation)
            try data?.write(to: savePath)
        } catch {
            print("Failed to save navigation path")
        }
    }
}

struct Materials: View {
    
    // start with 'state' and if shared in other struct/class use 'bi 
    @State private var pathStore = PathStore()
    
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            
            DetailView2(number: 0, path: $pathStore.path)
            
            .navigationDestination(for: Int.self) { num in
                DetailView2(number: num, path: $pathStore.path)
            }
        }
    }
    
}

//struct Materials: View {
//    
//    @State private var path = NavigationPath()
//    
//    var body: some View {
//        
//        NavigationStack(path: $path) {
//            List {
//                ForEach(0 ..< 5) { index in
//                    NavigationLink("Select Number: \(index)", value: index)
//                }
//                
//                ForEach (0 ..< 5) { index in
//                    NavigationLink("Select String Number: \(index)", value: String(index))
//                }
//            }
//            
//            .toolbar {
//                Button("Push 556") {
//                    path.append(556)
//                }
//                Button("Push Hello") {
//                    path.append("556")
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected int \(selection)")
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected string \(selection)")
//            }
//        }
//    }
//}

//struct Materials: View {
//    
//    @State private var path = [Int]()
//    
//    var body: some View {
//        NavigationStack(path: $path) { // 2 way binding, automatically updates to path
//            VStack {
//                // more code to come
//                Button("Show 32") {
//                    path = [32]
//                }
//                
//                Button("Show 64") {
//                    path.append(64)
//                }
//                
//                Button("Show 32 then 64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//        }
//    }
//}

//struct Materials: View {
//    var body: some View {
//        NavigationStack {
//            List(0 ..< 100) { index in
//                NavigationLink("Select \(index)", value: index)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//            .navigationDestination(for: Student.self) { student in
//                Text("You selected \(student.name)")
//            }
//        }
//    }
//}

//struct Materials: View {
//    var body: some View {
//        NavigationStack {
//            List(0 ..< 1000) { index in // creates detail view when loading... we don't want that...
//                NavigationLink() {
//                    DetailView(number: index)
//                } label: {
//                    Text("test")
//                }
//            }
//        }
//    }
//}

#Preview {
    Materials()
}
