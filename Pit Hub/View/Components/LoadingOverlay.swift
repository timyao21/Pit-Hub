//
//  LoadingOverlay.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/2/25.
//
import SwiftUI

struct LoadingOverlay: View {
    var tint: Color = Color(S.pitHubIconColor)
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)      // iOS‑style blur with translucency
                .ignoresSafeArea()             // cover every pixel

            ProgressView()
                .progressViewStyle(.circular)  // iOS 15+ shorthand
                .tint(tint)                    // custom accent color
                .scaleEffect(1.25)             // a touch larger for readability
        }
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlay()
    }
}

