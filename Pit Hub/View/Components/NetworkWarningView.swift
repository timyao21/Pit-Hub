//
//  NetworkWarningView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/8/25.
//

import SwiftUI

struct NetworkWarningView: View {
    var body: some View {
        VStack(spacing: 3) {
            Text("Check, Check, Radio Check")
                .fontWeight(.bold)
            HStack {
                Image(systemName: "network.slash")
                    .foregroundColor(.primary)
                Text("No Internet Connection")
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
}

#Preview {
    NetworkWarningView()
}
