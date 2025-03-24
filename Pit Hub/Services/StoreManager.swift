//
//  StoreManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/14/25.
//

import Foundation
import StoreKit

struct StoreManager {
    func checkMember() async -> Bool{
        do {
            // If they’ve unlocked lifetime, no need to check yearly
            if try await isPurchased(Products.lifetime) {
                print(">>> Lifetime purchased")
                return true
            }
            
            return try await isPurchased(Products.yearly)
            
        } catch {
            print("Failed to load product: \(error)")
            return false
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
            case .verified(let safe):
            return safe
        case .unverified:
            throw StoreKitError.unknown
            
        }
    }
    
    func isPurchased(_ productIdentifier: String) async throws -> Bool {
        guard let result = await Transaction.latest(for: productIdentifier) else{
            return false
        }
        let transaction = try checkVerified(result)
        return transaction.revocationDate == nil
    }
    
}
