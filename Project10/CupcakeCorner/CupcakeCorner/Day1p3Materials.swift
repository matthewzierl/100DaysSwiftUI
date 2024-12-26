//
//  Day1p3Materials.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 12/25/24.
//

import Foundation
import SwiftUI

struct Day1p3Materials: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create Account") {
                    print("Creating Account...")
                }
                .disabled(disableForm)
            }
            
        }
    }
}

#Preview {
    Day1p3Materials()
}
