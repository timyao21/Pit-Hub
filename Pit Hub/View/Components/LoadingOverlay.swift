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
        ZStack {
            // A clear background that allows the underlying content to show through.
            Color.clear
                .ignoresSafeArea()
            
            // Centered loading indicator with a translucent background.
            VStack(spacing: 16) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: tint))
                    .scaleEffect(1.25)
                Text(message)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(15)
            .background(.ultraThinMaterial) // Provides a translucent blurred effect.
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

struct LoadingOverlay_Previews: PreviewProvider {
    static var previews: some View {
        LoadingOverlay()
    }
}

