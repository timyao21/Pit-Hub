//
//  StoreManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/14/25.
//

import Foundation
import StoreKit

@MainActor
@Observable class StoreManager {
    @MainActor var product: Product?
    
    func loadProduct() async {
        do {
            let products = try await Product.products(for: [Products.yearly])
            self.product = products.first
            
        } catch {
            print("Failed to load product: \(error)")
        }
    }
    
}
