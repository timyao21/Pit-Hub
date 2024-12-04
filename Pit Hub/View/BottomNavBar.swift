//
//  BottomNavBar.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI

struct BottomNavBar: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView (selection: $selectedTab) {
            ScheduleView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
                .tag(0)
            HomePageView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(1)
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "trophy")
                }
                .tag(2)
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "newspaper")
                }
                .tag(3)
        }
    }
}

#Preview {
    BottomNavBar()
}
