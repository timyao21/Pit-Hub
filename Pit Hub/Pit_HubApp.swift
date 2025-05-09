//
//  Pit_HubApp.swift
//  Pit Hub
//
//  Created by Junyu Yao on 11/29/24.
//

import SwiftUI
import SwiftData

@main
struct Pit_HubApp: App {
    // MARK: - AppStorage

    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedWeatherUnit") private var selectedWeatherUnit: WeatherUnit = .celsius
//    store membership to local
    @AppStorage("membership") private var cachedMembership = false
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BottomNavBarIndexView()
                .preferredColorScheme(
                    selectedTheme == .system ? nil : (selectedTheme == .light ? .light : .dark)
                )
                .modelContainer(for: [DriverNickname.self])
        }
    }
}
