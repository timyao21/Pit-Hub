//
//  BottomNavBarIndexViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import Foundation
import SwiftUI

@Observable class IndexViewModel{
    // MARK: - Data Manager
    let storeManager = StoreManager()
    
//    Data Loading view
    @MainActor var isLoading: Bool = true
    
    // MARK: - Check Membership
    @MainActor var membership: Bool = false
    @MainActor var subscriptionSheetIsPresented: Bool = false
    
    // MARK: - Home Page GP Data
    @MainActor
    init() {
        Task {
            self.isLoading = true
            if UserDefaults.standard.bool(forKey: "membership") == false {
                await checkMembership()
            }
            self.isLoading = false
        }
    }
    
    @MainActor
    func checkMembership() async {
        print("Checking membership status...")
        if await storeManager.checkMember() {
            UserDefaults.standard.set(true, forKey: "membership")
            print("User is a member")
        } else {
            UserDefaults.standard.set(false, forKey: "membership")
            print("User is not a member")
        }
//        await membership = storeManager.checkMember()
    }
        
    // MARK: - End
}
