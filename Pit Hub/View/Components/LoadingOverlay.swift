//
//  LoadingOverlay.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/2/25.
//

import SwiftUI

struct LoadingOverlay: View {
    var message: String = "Loading..."
    var tint: Color = Color(S.pitHubIconColor)
    
    var body: some View {
        Color.black.opacity(0.4)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .overlay(
                ProgressView(message)
                    .progressViewStyle(CircularProgressViewStyle(tint: tint))
            )
    }
}


#Preview {
    LoadingOverlay()
}
