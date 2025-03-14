//
//  inapptest.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/13/25.
//

import SwiftUI
import StoreKit

struct inapptest: View {
    var body: some View {
        StoreView(ids: [Products.yearly])
            .productViewStyle(.compact)
    }
}

#Preview {
    inapptest()
}
