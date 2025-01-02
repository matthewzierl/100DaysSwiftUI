//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Matthew Zierl on 12/29/24.
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showConfirmation = false
    @State private var orderFailed = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your Total Cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank You!", isPresented: $showConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Order Failed", isPresented: $orderFailed) {
            Button("OK") {}
        } message: {
            Text("Please check your internet connection and try again.")
        }
    }
    
    func placeOrder() async {
        
        // convert to JSON
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!"
            showConfirmation = true
        } catch {
            print("Checkout Failed: \(error.localizedDescription)")
            orderFailed = true
        }
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
