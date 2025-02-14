//
//  SplashView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct SplashView: View {
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @Environment(\.colorScheme) private var scheme
    
    @State private var isActive: Bool = false
    
    var body: some View {
        Group {
            if isActive {
                BottomNavBarIndexView()
            } else {
                SplashScreenContent()
            }
        }
        .preferredColorScheme(userTheme.colorScheme(for: scheme))
        .onAppear {
            startSplashTimer()
        }
    }
    
    // Extracted Splash Screen Content
    @ViewBuilder
    private func SplashScreenContent() -> some View {
        ZStack {
            Rectangle()
                .fill(Color(S.primaryBackground))
                .ignoresSafeArea()
            HStack {
                Image("PitIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                Text("Pit Hub")
                    .font(.custom(S.orbitron, size: 40))
                    .foregroundColor(Color(S.pitHubIconColor))
                    .bold()
            }
        }
    }
    
    // Timer to transition from SplashView to BottomNavBar
    private func startSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.isActive = true
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
