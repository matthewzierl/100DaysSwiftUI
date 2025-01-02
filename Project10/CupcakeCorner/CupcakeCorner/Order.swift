//
//  Order.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 12/26/24.
//

import Foundation
import SwiftUI

@Observable
class Order: Codable {
    static let types: [String] = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"
        case _phoneNumber = "phoneNumber"
        case _email = "email"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
    }
    
    
    
    var type = 0
    var quantity = 3
    
    var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    var streetAddress: String {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    var city: String {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    var zip: String {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }
    var phoneNumber: String {
        didSet {
            UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        }
    }
    var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: "email")
        }
    }
    
    init() {
        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        self.streetAddress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        self.city = UserDefaults.standard.string(forKey: "city") ?? ""
        self.zip = UserDefaults.standard.string(forKey: "zip") ?? ""
        self.phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber") ?? ""
        self.email = UserDefaults.standard.string(forKey: "email") ?? ""
        print("intializing order")
    }
    
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        // $2 per cupcake
        var cost = Decimal(quantity) * 2
        
        // complicated cakes cost more
        cost += Decimal(type) // types indexed in increasing order of cake prices
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        if addSprinkles {
            cost += Decimal(quantity) * 0.5
        }
        
        return cost
    }
    
    var specialRequestEnabled: Bool = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    
}
