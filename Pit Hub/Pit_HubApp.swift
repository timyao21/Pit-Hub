//
//  Pit_HubApp.swift
//  Pit Hub
//
//  Created by Junyu Yao on 11/29/24.
//

import SwiftUI

@main
struct Pit_HubApp: App {
    
    let persistenceController = PersistenceController.shared
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedLanguage") private var selectedLanguage: AppLanguage = .chinese
    @AppStorage("selectedWeatherUnit") private var selectedWeatherUnit: WeatherUnit = .celsius
    
    var body: some Scene {
        WindowGroup {
            BottomNavBarIndexView()
                .preferredColorScheme(
                    selectedTheme == .system ? nil : (selectedTheme == .light ? .light : .dark)
                )
        }
    }
}
