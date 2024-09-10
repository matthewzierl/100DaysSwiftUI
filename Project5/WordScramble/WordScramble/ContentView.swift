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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    
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
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Text("Score: \(score)")
                }
                ToolbarItemGroup {
                    Button("Star Game") {
                        startGame()
                    }
                }
            }
            .onSubmit { // closure for when user presses return on keyboard
                addNewWord()
            }
            .onAppear {
                startGame()
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func isValid(word: String) -> Bool {
        guard word != rootWord else { return false }
        guard word.count >= 3 else { return false }
        return true
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
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missprelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missprelledRange.location == NSNotFound // nothing found
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) // lowercase, trim word
        guard answer.count > 0 else { return } // check it is not empty
        
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word Used Already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word Not Possible", message: "Please use character set from \(rootWord)")
            return
        }
        guard isValid(word: answer) else {
            wordError(title: "Invalid Answer", message: "Word must be 3 characters or longer and not match the root word")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word Not Real", message: "Please make a real word")
            return
        }
        
        withAnimation { // make animation for insertion???
            usedWords.insert(answer, at: 0)
        }
        
        score += answer.count
        
        newWord = "" // reset newWord
    }
    
    func startGame() {
        
        if let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            
            // found file in bundle
            
            if let fileContents = try? String(contentsOf: fileURL) {
                
                
                // can convert contents to string
                let wordBank = fileContents.components(separatedBy: "\n")
                rootWord = wordBank.randomElement() ?? "FUCK"
                
                // clear any previous words
                usedWords.removeAll()
                score = 0
                
                return
                
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
    
}

#Preview {
    ContentView()
}
