//
//  BottomNavBar.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI

struct BottomNavBarIndexView: View {
    
    @State private var networkMonitor = NetworkMonitor()
//    @State private var viewModel = IndexViewModel()
    @Environment(IndexViewModel.self) private var indexViewModel
    
    @State private var showNetworkWarning = false
    @State private var selectedTab = 0
    
    var body: some View {
        @Bindable var viewModel = indexViewModel
        
        // index ZStack
        ZStack {
            TabView (selection: $selectedTab) {
                
//                Homepage
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(0)
                
//                Standings View
                NavigationStack{
                    StandingsView()
                }
                .tabItem {
                    Label("Standings", systemImage: "trophy")
                }
                .tag(1)
                
//                AcademyView
                NavigationStack{
                    AcademyView()
                }
                .tabItem {
                    Label("Academy", systemImage: "text.book.closed.fill")
                }
                .tag(2)
                
            }
            
//            Overlay the loading
            if viewModel.isLoading {
                LoadingOverlay()
            }
            
//            Overlay the network problem
            if showNetworkWarning {
                NetworkWarningView()
                    .padding(.horizontal)
                    .transition(.move(edge: .top))
                    .animation(.easeInOut, value: showNetworkWarning)
            }
        }
//        Subscription 
        .sheet(isPresented: $viewModel.subscriptionSheetIsPresented) {
            InAppPurchases()
                .presentationDetents([.medium])
        }
//        .environment(viewModel)
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
        .environment(IndexViewModel())
}
