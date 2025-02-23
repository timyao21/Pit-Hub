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
        
        ScrollView{
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
                    RaceSection(for: viewModel.upcomingGP)
                        .padding(.bottom, 10)
                }
                HomeWeatherRow()
                Spacer()
                if let lat = viewModel.upcomingGP?.circuit.location.lat,
                   let long = viewModel.upcomingGP?.circuit.location.long,
                   lat != "0", long != "0" {
                    CircuitMapView(lat: lat, long: long)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeView()
}
