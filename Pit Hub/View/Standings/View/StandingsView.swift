//
//  StandingsView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/15/25.
//

import SwiftUI

struct StandingsView: View {
    @State private var selectedTab = 0
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                // Page 1: Driver Standings
                ScrollView {
                    ForEach(viewModel.drivers) { driver in
                        NavigationLink(destination: DriverDetailView(driver: driver)) {
                            StandingsRowView(driver: driver)
                        }
                        .buttonStyle(PlainButtonStyle()) // Prevents highlighting effect on NavigationLink
                    }
                }
                .tag(0)

                // Page 2: Team Standings (Placeholder)
                VStack {
                    Text("Team Standings")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Enables swipeable pages
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text(selectedTab == 0 ? "Driver Standings" : "Constructors Standings")
                        .font(.custom(S.smileySans, size: 30)) // Replace with your custom font
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(S.pitHubIconColor),Color.yellow]), startPoint: .leading, endPoint: .trailing))
                }
            }
            .onAppear {
//                viewModel.fetchDrivers()
            }
        }
    }
}

#Preview {
    StandingsView()
}
