//
//  HomeView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @Bindable var viewModel: IndexViewModel
    @State private var isSettingsPresented: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 3){
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
                    // Gear icon button for presenting settings as a sheet
                    Button {
                        isSettingsPresented = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(S.pitHubIconColor))
                    }
                }
                
                NavigationLink {
                    RaceCalendarView(viewModel: viewModel)
                        .toolbar(.hidden, for: .tabBar)
                } label: {
                    VStack{
                        HStack{
                            PitSubtitle(for: "Next Race")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(systemName: "calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23, height: 23)
                                .foregroundColor(Color(S.pitHubIconColor))
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color(S.pitHubIconColor))
                        }
                        .padding(.vertical)
                        if viewModel.allUpcomingGP.isEmpty {
                            Text("No upcoming races")
                                .foregroundColor(.secondary)
                                .frame(height: 170)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else{
                            HomeCalendarView(for: viewModel.allUpcomingGP)
                                .frame(height: 170)
                        }
                    }
                }
                
                Divider()
                
                if let upcomingGP = viewModel.upcomingGP {
                    RaceCalendarDetailView(for: upcomingGP, homepage: true)
                        .padding(.horizontal, -16)
                        .padding(.bottom, 10)
                } else {
                    DataErrorView()
                        .frame(height: 300)
                }
                
                PitSubtitle(for: "Race Day Weather Forecasts")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                if (viewModel.membership == true){
                    if (viewModel.upcomingGP != nil){
                        HomeWeatherRow(viewModel: viewModel)
                    }
                }else{
                    UnlockView()
                        .cornerRadius(10)
                        .shadow(radius:3,x: 3,y: 3)
                }
                
                if let lat = viewModel.upcomingGP?.circuit.location.lat,
                   let long = viewModel.upcomingGP?.circuit.location.long,
                   lat != "0", long != "0" {
                    PitSubtitle(for: "Circuit Location")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    CircuitMapView(lat: lat, long: long)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
    }
}
