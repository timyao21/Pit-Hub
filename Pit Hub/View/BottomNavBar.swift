//
//  BottomNavBar.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI

struct BottomNavBar: View {
    @State private var selectedTab = 1
    @State private var showNavBar = true // State to toggle visibility
    
    @Environment(\.colorScheme) private var scheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    var body: some View {
        TabView (selection: $selectedTab) {
            ScheduleListView()
                .tabItem {
                    Label("赛历", systemImage: "calendar")
                }
                .tag(0)
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("主页", systemImage: "house")
            }
            .tag(1)
            StandingsView()
                .tabItem {
                    Label("积分", systemImage: "trophy")
                }
                .tag(2)
            ContentView()
                .tabItem {
                    Label("新闻", systemImage: "newspaper")
                }
                .tag(3)
        }
    }
}

#Preview {
    BottomNavBar()
}
