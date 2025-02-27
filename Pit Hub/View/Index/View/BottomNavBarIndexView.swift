//
//  BottomNavBar.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI

struct BottomNavBarIndexView: View {
    @State private var selectedTab = 1
    @State private var showNavBar = true // State to toggle visibility
    
    @StateObject private var viewModel = IndexViewModel()
    
    var body: some View {
        TabView (selection: $selectedTab) {
            
            NavigationStack {
                RaceCalendarView(viewModel: viewModel)
            }
            .tabItem {
                Label("Calendar", systemImage: "calendar")
            }
            .tag(0)
            
            NavigationStack {
                HomeView(viewModel: viewModel)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(1)
            
            NavigationStack{
                StandingsView(viewModel: viewModel)
            }
            .tabItem {
                Label("Standings", systemImage: "trophy")
            }
            .tag(2)
        }
    }
}

#Preview {
    BottomNavBarIndexView()
}
