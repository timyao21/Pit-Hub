//
//  HomeView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = IndexViewModel()
    
    var body: some View {
            VStack(spacing: 0){
                HStack {
                    Image(S.pitIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                    Text(S.title)
                        .foregroundColor(Color(S.pitHubIconColor))
                        .font(.custom(S.orbitron, size: 30))
                        .bold()
                    Spacer()
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(S.pitHubIconColor))
                }
                .padding(.bottom, 10)
                if (viewModel.upcomingGP != nil){
                    HomeRaceRow(upcomingGP: viewModel.upcomingGP)
                }
                Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
