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

enum WeatherUnit: String, CaseIterable, Identifiable {
    case celsius = "°C"
    case fahrenheit = "°F"
    
    var id: String { rawValue }
}

struct SettingsView: View {
    @Environment(\.openURL) private var openURL
    
    // Using AppStorage to persist user settings
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedLanguage") private var selectedLanguage: AppLanguage = .chinese
    @AppStorage("selectedWeatherUnit") private var selectedWeatherUnit: WeatherUnit = .celsius
    
    @State private var seasonPassSheetIsPresented: Bool = false
    
    init() {
        let segmentedAppearance = UISegmentedControl.appearance()
        segmentedAppearance.selectedSegmentTintColor = UIColor(Color(S.pitHubIconColor))  // Custom selected color
        
        segmentedAppearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Section for appearance settings
                Section(header: Text("Pit App Paddock Pass")) {
                    Button("Button") {
                        seasonPassSheetIsPresented = true
                    }
                }
                Section(header: Text("Tune Your Look")) {
                    Picker("Language", selection: $selectedLanguage) {
                        ForEach(AppLanguage.allCases) { language in
                            Text(language.displayName)
                                .tag(language)
                        }
                    }

                    Picker("App Theme", selection: $selectedTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(LocalizedStringKey(theme.rawValue))
                                .fontWeight(.semibold)
                                .tag(theme)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(3)
                    
                    Picker("Weather Unit", selection: $selectedWeatherUnit) {
                        ForEach(WeatherUnit.allCases) { unit in
                            Text(unit.rawValue)
                                .tag(unit)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Section for language settings
//                Section(header: Text("About")) {
//                    Text("Pit App is proudly crafted and developed by Junyu Yao and Jiyang He.")
//                    NavigationLink(destination: About()) {
//                        Text("About Us")
//                    }
//                }
                
                Section(header: Text("About")) {
                    let aboutText: AttributedString = {
                        var string = AttributedString("Pit App is proudly crafted and developed by Junyu Yao, with artistic and creative vision provided by Jiyang He.")
                        if let range = string.range(of: "Junyu Yao") {
                            string[range].link = URL(string: "https://yjytim.com/")!
                            string[range].foregroundColor = .blue
                            string[range].underlineStyle = .single
                        }
                        return string
                    }()
                    
                    Text(aboutText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
                    NavigationLink(destination: About()) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                            Text("Learn More About Us")
                                .fontWeight(.medium)
                        }
                        .padding(.vertical, 4)
                    }
                    
                    Text("Follow Us")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack{
                        Button("On bilibili") {
                            let urlString = "https://space.bilibili.com/626701417?spm_id_from=333.1365.0.0"
                            if let url = URL(string: urlString) {
                                openURL(url)
                            }
                        }
                    }
                    
                    Button("Report") {
                        let email = "yjy197@outlook.com"  // Replace with your email address
                        let subject = "Report Issue - Pit App"
                        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        if let url = URL(string: "mailto:\(email)?subject=\(encodedSubject)") {
                            openURL(url)
                        }
                    }
                    
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

