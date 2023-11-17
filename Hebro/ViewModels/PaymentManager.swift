//
//  PaymentManager.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

import Foundation

class PaymentManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Float = 0
    
    // Payment-related variables
    let paymentHandler = PaymentHandler()
    @Published var paymentSuccess = false
    
    
    // Call the startPayment function from the PaymentHandler. In the completion handler, set the paymentSuccess variable
    func pay() {
        paymentHandler.startPayment(products: products, total: total) { success in
            self.paymentSuccess = success
            self.products = []
         
        }
    }
}
