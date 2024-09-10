//
//  ContentView.swift
//  WordScramble
//
//  Created by Matthew Zierl on 9/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Create a Word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Created Words") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            
            .navigationTitle(rootWord)
            .onSubmit { // closure for when user presses return on keyboard
                addNewWord()
            }
            .onAppear {
                startGame()
            }
        }
    }
    
    /*
        Not already in word bank
     */
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        
        var tempWord = rootWord // make copy of root
        
        for letter in word { // loop thru provided word's chars
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos) // remove each char from root copy
            } else {
                return false // not found, then false
            }
        }
        return true // made it thru all characters in word
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) // lowercase, trim word
        guard answer.count > 0 else { return } // check it is not empty
        
        // TODO: Word Validity
        
        withAnimation { // make animation for insertion???
            usedWords.insert(answer, at: 0)
        }
        newWord = "" // reset newWord
    }
    
    func startGame() {
        
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            // found file in bundle
            
            if let fileContents = try? String(contentsOf: fileURL) {
                
                
                // can convert contents to string
                let wordBank = fileContents.components(separatedBy: "\n")
                rootWord = wordBank.randomElement() ?? "FUCK"
                return
                
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
}

#Preview {
    ContentView()
}
