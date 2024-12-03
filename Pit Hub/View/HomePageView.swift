//
//  HomePageView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/2/24.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Hello, F1 World! this is \(S.title)")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                Image("PitHubIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 40) // Adjust the size as needed
                }
            }
        }
    }
}

#Preview {
    HomePageView()
}
