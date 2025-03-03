//
//  SettingView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/26/25.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
    
    var id: String { rawValue }
}

struct SettingsView: View {
    // Using AppStorage to persist user settings
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedLanguage") private var selectedLanguage: String = "English"
    
    // List of available languages (you can expand this list as needed)
    private let languages = ["中文", "English"]
    
    // Customize UISegmentedControl appearance
    init() {
        let segmentedAppearance = UISegmentedControl.appearance()
        segmentedAppearance.selectedSegmentTintColor = UIColor(Color(S.pitHubIconColor))  // Custom selected color
        

        segmentedAppearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Section for appearance settings
                Section(header: Text("Appearance")) {
                    Picker("App Theme", selection: $selectedTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.rawValue)
                                .fontWeight(.semibold)
                                .tag(theme)
                        }
                    }
                    // Using a segmented picker style for a compact UI
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Section for language settings
                Section(header: Text("Language")) {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    // You could use a default picker style or a wheel style if preferred
                }
            }
            .navigationTitle("Pit Line")
        }
        .preferredColorScheme(
            selectedTheme == .system ? nil : (selectedTheme == .light ? .light : .dark)
        )
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

