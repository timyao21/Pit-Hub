//
//  inapptest.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/13/25.
//

import SwiftUI
import StoreKit

struct inapptest: View {
    let storeManager = StoreManager()

    var body: some View {
        VStack {
            SubscriptionStoreView(productIDs: ["com.yjytim.PitHub.YearlyPlan"]){
                ProductsHeaderView()
                
            }
            .storeButton(.visible, for: .redeemCode)
            .storeButton(.visible, for: .restorePurchases)
        }
        .onAppear {
            Task {
                await storeManager.checkMember()
            }
        }
    }
}

#Preview {
    inapptest()
}

struct ProductsHeaderView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        VStack {
            Image(S.pitIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 188)
                .padding()
            Text("Get your Season Pass for Pit App")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
