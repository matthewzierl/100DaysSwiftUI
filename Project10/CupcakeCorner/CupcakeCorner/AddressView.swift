//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 12/26/24.
//

import SwiftUI

struct AddressView: View {
    
    /*
        Address View doesn't have access to 2-way binding from '@State' in ContentView when order was first created
        Use Case: If you receive an obervable object, use the '@Bindable' to create 2-way binding back ot observable object
        '@State' for observable objects is only used upon creation
     */
    @Bindable var order: Order
        
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Phone Number", text: $order.phoneNumber)
                TextField("Email", text: $order.email)
            }
            Section {
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink("Checkout", destination: CheckoutView(order: order))
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
