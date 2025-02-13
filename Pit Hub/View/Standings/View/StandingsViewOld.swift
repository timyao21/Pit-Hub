//
//  StandingsView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/15/25.
//

//import SwiftUI
//
//struct StandingsViewOld: View {
//    @State private var selectedTab = 0
//    @StateObject var viewModel = ViewModel()
//    
//    var body: some View {
//        NavigationView {
//            TabView(selection: $selectedTab) {
//                // MARK: - Page 1 Drivers
//                VStack {
//                    standingTitle(selectedTab: 0)
//                    ScrollView {
//                        VStack(spacing: 0) {
//                            ForEach(viewModel.F1Drivers.indices, id: \.self) { index in
//                                let driver = viewModel.F1Drivers[index]
//                                NavigationLink(destination: DriverDetailView(driver: driver, position: index + 1)) {
//                                    StandingsRowViewOld(driver: driver, position: index + 1)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                                
//                                if index < viewModel.F1Drivers.count - 1 { // Avoids divider after the last row
//                                    Divider()
//                                }
//                            }
//                        }
//                    }
//                    .tag(0)
//                }
//                // Page 2: Team Standings (Placeholder)
//                VStack {
//                    standingTitle(selectedTab: 1)
//                    VStack(spacing: 0) {
//                        ForEach(viewModel.F1Teams.indices, id: \.self) { index in
//                            let team = viewModel.F1Teams[index]
//                            StandingsTeamRowView(team: team, position: index + 1)
//                            
//                            if index < viewModel.F1Drivers.count - 1 { // Avoids divider after the last row
//                                Divider()
//                            }
//                        }
//                        Spacer()
//                    }
//                }
//                .tag(1)
//            }
//            .padding(8)
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Enables swipeable pages
//            .onAppear {
//                viewModel.loadDrivers(for: viewModel.selectedYear)
//            }
//        }
//    }
//}
//
//#Preview {
//    StandingsViewOld()
//}
//
//// MARK: - standingTitle
//struct standingTitle: View {
//    var selectedTab: Int
//    
//    var body: some View {
//        HStack {
//            Text(selectedTab == 0 ? "Driver Standings" : "Constructors Standings")
//                .font(.custom(S.smileySans, size: 30)) // Replace with your custom font
//                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(S.pitHubIconColor),Color.yellow]), startPoint: .leading, endPoint: .trailing))
//            Spacer()
//        }
//    }
//}
