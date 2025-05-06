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
    
    @Environment(IndexViewModel.self) private var viewModel
    @Environment(\.dismiss)           private var dismiss
    @State private var showSafari = false
    @State private var selectedURL: IdentifiableURL?

    let termsURL = URL(string: "https://developer.apple.com/app-store/review/guidelines/#legal")!
    let policyURL = URL(string: "https://yjytim.notion.site/Privacy-Policy-1d07a0c9b0ac80639353fd8641d268d3?pvs=4")!
    
    var body: some View {
        VStack {
            SubscriptionStoreView(productIDs: [Products.yearly]){
                ProductsHeaderView()
                    .frame(maxWidth: .infinity)
            }
            .storeButton(.visible, for: .redeemCode)
            .storeButton(.visible, for: .restorePurchases)
            .onInAppPurchaseCompletion { _, outcome in
                switch outcome {
                    
                // ─────────── Success path ───────────
                case .success(let state):
                    switch state {
                    case .success(let verification):
                        guard case .verified(let transaction) = verification else { return }
                        await transaction.finish()
                        await viewModel.checkMembership()
                        dismiss()                            // close paywall
                        
                    case .pending:
                        print("Purchase pending…")           // Ask‑to‑Buy, etc.
                        
                    case .userCancelled:
                        break                                // no action
                        
                    @unknown default:
                        break
                    }
                    
                // ─────────── Failure path ───────────
                case .failure(let error):
                    print("Purchase failed: \(error.localizedDescription)")
                }
            }

            
            HStack(spacing: 15) {
                Button {
                    selectedURL = IdentifiableURL(url: termsURL)
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "doc.text")
                        Text("Terms of Service")
                    }
                    .foregroundColor(.primary)
                }

                Button {
                    // Set the URL and the sheet appears when selectedURL is non-nil.
                    selectedURL = IdentifiableURL(url: policyURL)
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: "lock")
                        Text("Privacy Policy")
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .sheet(item: $selectedURL) { item in
            SafariView(url: item.url)
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
                Text("Get your PitLane+ Paddock Club Annual Pass")
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
