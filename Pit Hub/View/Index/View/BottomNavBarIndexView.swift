//
//  BottomNavBar.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI

struct BottomNavBarIndexView: View {
    
    @State private var networkMonitor = NetworkMonitor()
    @State private var viewModel = IndexViewModel()
    
    @State private var showNetworkWarning = false
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView (selection: $selectedTab) {
                
                NavigationStack {
                    HomeView(indexViewModel: viewModel)
                        .refreshable {
                            Task{
                                await viewModel.refreshHomeGPData()
                            }
                        }
                }
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0)
                
                NavigationStack{
                    StandingsView()
                }
                .tabItem {
                    Label("Standings", systemImage: "trophy")
                }
                .tag(1)
                
                NavigationStack{
                    AcademyView()
                }
                .tabItem {
                    Label("Academy", systemImage: "text.book.closed.fill")
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
        .sheet(isPresented: $viewModel.subscriptionSheetIsPresented) {
            InAppPurchases()
                .presentationDetents([.medium])
        }
        .environment(viewModel)
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
    }
}

#Preview {
    BottomNavBarIndexView()
}
