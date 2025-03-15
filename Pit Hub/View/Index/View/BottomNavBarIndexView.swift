//
//  BottomNavBar.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI

struct BottomNavBarIndexView: View {
    @State private var selectedTab = 1
    
    @State private var networkMonitor = NetworkMonitor()
    @State private var viewModel = IndexViewModel()
    
    @State private var showNetworkWarning = false
    
    var body: some View {
        ZStack {
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
                        .refreshable {
                            Task{
                                await viewModel.refreshHomeGPData()
                            }
                        }
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
            if showNetworkWarning {
                NetworkWarningView()
                    .padding(.horizontal)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: showNetworkWarning)
            }
        }
        .onChange(of: networkMonitor.isActive) { oldValue, newValue in
            DispatchQueue.main.async {
                if !newValue {
                    showNetworkWarning = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        showNetworkWarning = false
                    }
                } else {
                    showNetworkWarning = false
                }
            }
        }
        .environment(viewModel)
        .subscriptionStatusTask(for: "21650064") { taskStatus in
            print("Subscription status task status:\(taskStatus)")
        }
    }
}

#Preview {
    BottomNavBarIndexView()
}
