//
//  MaterialsP2.swift
//  Bookworm
//
//  Created by Matthew Zierl on 1/2/25.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .padding()
    }
}

struct TextFieldView: View {
    
    @Binding var text: String
    
    var body: some View {
        TextField("Enter Text", text: $text, axis: .vertical)
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

struct MaterialsP2: View {
    
    @AppStorage("notes") var notes: String = ""
    
    var body: some View {
        NavigationStack {
//            TextEditorView(text: $notes)
            TextFieldView(text: $notes)
            .navigationTitle(Text("Notes App"))
        }
    }
}

#Preview {
    MaterialsP2()
}
