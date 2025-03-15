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
            SubscriptionStoreView(groupID: "21650064"){
                ProductsHeaderView()
            }
        }
        .onAppear {
            Task {
                await storeManager.loadProduct()
            }
        }
    }
}

#Preview {
    inapptest()
}

struct ProductsHeaderView: View {
    var body: some View {
        VStack {
            Image(S.pitIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            Text("Get your Season Pass for Pit App")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}
