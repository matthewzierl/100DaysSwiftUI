//
//  MaterialsP5.swift
//  BucketList
//
//  Created by Matthew Zierl on 1/21/25.
//

import LocalAuthentication
import SwiftUI

struct MaterialsP5: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    // good to go
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

#Preview {
    MaterialsP5()
}
