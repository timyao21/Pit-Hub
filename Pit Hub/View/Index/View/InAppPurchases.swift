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
    @AppStorage("membership") private var cachedMembership = false
    
//    @State private var showSafari = false
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
//            Handle outcome
            .onInAppPurchaseCompletion { _, outcome in
                guard case .success(let state) = outcome else {
                    if case .failure(let error) = outcome {
                        print(error)
                    }
                    return
                }
                
                switch state {
                case .success(let verification):
                    guard case .verified(let transaction) = verification else { return }
                    print(1)
                    await MainActor.run {
                        cachedMembership = true
                        dismiss()
                    }
                    print(2)
                    await transaction.finish()
                    print(3)
                    
                case .pending:
                    print("Purchase pending…")           // Ask‑to‑Buy, etc.
                    
                case .userCancelled:
                    print("User cancelled purchase…")
                    break                                // no action
                    
                @unknown default:
                    print("Error occurred: unknown default case")
                    break
                    
                }
                
            }

            termsAndPolicyButtons
        }
        .sheet(item: $selectedURL) { item in
            SafariView(url: item.url)
        }
    }
    
    @ViewBuilder
    private var termsAndPolicyButtons: some View {
        HStack(spacing: 15) {
            Button { selectedURL = IdentifiableURL(url: termsURL) } label: {
                Label("Terms of Service", systemImage: "doc.text")
            }
            Button { selectedURL = IdentifiableURL(url: policyURL) } label: {
                Label("Privacy Policy", systemImage: "lock")
            }
        }
        .foregroundStyle(.primary)
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
