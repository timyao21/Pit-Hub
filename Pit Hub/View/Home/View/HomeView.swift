//
//  HomeView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("membership") private var cachedMembership = false
    @Environment(IndexViewModel.self) private var indexViewModel
    @State private var viewModel = HomepageViewModel()
    @State private var isSettingsPresented: Bool = false
    
    var body: some View {
        ZStack{
//            Homeview Body
            ScrollView{
                VStack(spacing: 3){
                    
                    headerView
                    
                    NavigationLink {
                        RaceCalendarView(viewModel: viewModel)
                    } label: {
                        VStack{
                            sectionHeader(title: "Race Calendar", icon: "calendar", arrow: true)
                            
                            if viewModel.homepageUpcomingRaces.isEmpty {
                                HomeCalendarView(for: viewModel.homepageUpcomingRaces)
                                    .frame(height: 168)
                            } else{
                                HomeCalendarView(for: viewModel.homepageUpcomingRaces)
                                    .frame(height: 168)
                            }
                        }
                    }
                    
                    Divider()
                    
//                    PitSubtitle(for: "Next Race")
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.vertical)
                    
                    sectionHeader(title: "Next Race", icon: "flag.pattern.checkered.2.crossed", arrow: false)
                    
                    if let upcomingGP = viewModel.homepageUpcomingRace {
                        RaceSection(for: upcomingGP)
                            .padding(.bottom, 10)
                    } else {
                        DataErrorView()
                            .frame(height: 300)
                    }
                    
                    PitSubtitle(for: "Race Day Weather Forecasts")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical)
                    
                    if (cachedMembership == true){
                        if (viewModel.homepageUpcomingRace != nil){
                            HomeWeatherRow(for: viewModel.homepageUpcomingRace!)
                        }
                    }else{
                        UnlockView()
                            .cornerRadius(10)
                            .shadow(radius:3,x: 3,y: 3)
                    }
                    
                    if let lat = viewModel.homepageUpcomingRace?.circuit.location.lat,
                       let long = viewModel.homepageUpcomingRace?.circuit.location.long,
                       lat != "0", long != "0" {
                        PitSubtitle(for: "Circuit Location")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical)
                        CircuitMapView(lat: lat, long: long)
                    }
                }
                .padding()
            }
            
//            loading overlay
            if viewModel.isLoading {
                LoadingOverlay()
            }
        }
        .refreshable {
            Task{
                await indexViewModel.checkMembership()
                await viewModel.refreshHomepage()
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
    }
    
    // MARK: - Header View
    
    private func sectionHeader(title: LocalizedStringResource, icon: String, arrow: Bool) -> some View {
        HStack{
            PitSubtitle(for: title)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 23)
                .foregroundColor(Color(S.pitHubIconColor))
            if arrow {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color(S.pitHubIconColor))
            }
        }
        .padding(.vertical)
    }
    
    private var headerView: some View {
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
    }
    
    
    
    // MARK: - End of the view
}
