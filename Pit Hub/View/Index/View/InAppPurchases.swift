//
//  inapptest.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/13/25.
//

import SwiftUI
import StoreKit

struct InAppPurchases: View {
    let storeManager = StoreManager()
    
    var body: some View {
        VStack {
            SubscriptionStoreView(productIDs: [Products.yearly]){
                ProductsHeaderView()
                    .frame(maxWidth: .infinity)
            }
            .storeButton(.visible, for: .redeemCode)
            .storeButton(.visible, for: .restorePurchases)
        }
    }
}

struct ProductsHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Centered section: Image and title
            VStack(spacing: 5) {
                Image(S.pitIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 188)
                Text("Get your Pit App Paddock Club Annual Pass")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            // Left aligned section: Featured function row
            FeaturedFunctionsRow(for: "Race Day Weather Forecasts")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

private struct FeaturedFunctionsRow: View {
    let title: LocalizedStringKey
    
    init(for title: LocalizedStringKey) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Image(systemName: "bookmark.fill")
            Text(title)
        }
        .font(.headline)
    }
}


#Preview {
    InAppPurchases()
}
