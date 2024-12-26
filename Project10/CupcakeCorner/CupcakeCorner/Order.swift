//
//  Order.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 12/26/24.
//

import Foundation

@Observable
class Order {
    static let types: [String] = ["Vanilla", "Chocolate", "Strawberry", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
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
