//
//  HomeView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ViewModel()
    
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
            }
            .padding(.bottom, 10)
            if (viewModel.upcomingGP != nil){
                HomeRaceRow(upcomingGP: viewModel.upcomingGP)
            }
            HomeWeatherRow()
            Spacer()
        }
        .padding()
        .onAppear() {
            viewModel.loadAllGP()
        }
    }
}

#Preview {
    HomeView()
}
