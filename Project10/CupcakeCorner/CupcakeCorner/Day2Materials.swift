//
//  Day2Materials.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 12/25/24.
//

import Foundation
import SwiftUI

@Observable
class User: Codable {
    
    /*
     without enum of CodingKeys, whenever we send or receive JSON, it will be hard
     to decipher between 'variable' and '_variable', so when we receive or send JSON
     and decode or encode, the enum will automatically decode to 'variable' or encode
     to '_variable' to align with JSON conventions
     Reasons:
        1. Aligns external data structure (JSON) with Swift's preferred naming conventions
        2. Seamless decoding/encoding by automatically decoding from JSON or encoding back
        into JSON while keeping names aligned with JSON conventions
        3. Codingkeys enum encapsulates JSON structure within the enum, so external data
        structures are kept separate and hidden, which improves readability
     */
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name: String = "Matt"
}

struct Day2Materials: View {
    
    var body: some View {
        Button("Encode Matt", action: encodeMatt)
    }
    
    func encodeMatt() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    Day2Materials()
}
