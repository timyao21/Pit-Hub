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
    
    var body: some View {
        TabView (selection: $selectedTab) {
            ScheduleView()
                .tabItem {
                    Label("赛历", systemImage: "calendar")
                }
                .tag(0)
            HomePageView()
                .tabItem {
                    Label("主页", systemImage: "house")
                }
                .tag(1)
            ContentView()
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
