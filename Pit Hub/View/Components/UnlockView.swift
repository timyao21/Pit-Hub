//
//  UnlockView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/17/25.
//

import SwiftUI

struct UnlockView: View {
    @Environment(IndexViewModel.self) private var indexViewModel
    
    private let title: LocalizedStringKey = ""
    private let subtitle: LocalizedStringKey = "Subscribe to access full content."
    
    var body: some View {
        ZStack{
            Image(S.pitIcon)
                .resizable()
                .frame(width: 288, height: 288)
            
            // Semi-transparent background with blur effect for a modern look.
            Color(.systemBackground)
                .opacity(0.6)
                .ignoresSafeArea()
                .background(.ultraThinMaterial)
            
            VStack(spacing: 10){
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Text(subtitle)
                    .font(.body)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Button {
                    indexViewModel.subscriptionSheetIsPresented.toggle()
                } label: {
                    HStack {
                        Image(systemName: "flag.pattern.checkered.2.crossed")
                        Text("Subscribe")
                            .fontWeight(.bold)
                    }
                }
                .padding(8)
                .tint(.white)
                .background(Color(S.pitHubIconColor))
                .cornerRadius(12)
                
            }
        }
    }
}
