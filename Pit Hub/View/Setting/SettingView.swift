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
                    Button("Become Paddock Club Member") {
                        seasonPassSheetIsPresented = true
                    }
                }
                
                Section(header: Text("Tune Your Look")) {
                    HStack {
                        Image(systemName: "translate")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .cyan)
                        
                        Picker("Language", selection: $selectedLanguage) {
                            ForEach(AppLanguage.allCases) { language in
                                Text(language.displayName)
                                    .tag(language)
                            }
                        }
                    }
                    HStack{
                        Image(systemName: "iphone.app.switcher")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .indigo)
                        
                        Picker("App Theme", selection: $selectedTheme) {
                                
                                ForEach(AppTheme.allCases) { theme in
                                    Text(LocalizedStringKey(theme.rawValue))
                                        .fontWeight(.semibold)
                                        .tag(theme)
                                }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(3)
                    }
                    
                    HStack{
                        Image(systemName: "thermometer.medium")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .primary)
                        
                        Picker("Weather Unit", selection: $selectedWeatherUnit) {
                            ForEach(WeatherUnit.allCases) { unit in
                                Text(unit.rawValue)
                                    .tag(unit)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(3)
                    }
                }
                
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
                }
                
                Section(header: Text("Follow Us")) {
                    Button("Bilibili") {
                        let urlString = "https://space.bilibili.com/626701417?spm_id_from=333.1365.0.0"
                        if let url = URL(string: urlString) {
                            openURL(url)
                        }
                    }
                    .tint(.primary)
                    
                    Button("Rednotes") {
                        let urlString = "https://www.xiaohongshu.com/user/profile/635c844d000000001802a186"
                        if let url = URL(string: urlString) {
                            openURL(url)
                        }
                    }
                    .tint(.primary)
                }
                
                
                Section(header: Text("About")) {
                    Button("Report") {
                        let email = "yjy197@outlook.com"  // Replace with your email address
                        let subject = "Report Issue - Pit App"
                        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        if let url = URL(string: "mailto:\(email)?subject=\(encodedSubject)") {
                            openURL(url)
                        }
                    }
                    .tint(.primary)
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("v0.1.0")
                            .foregroundColor(.secondary)
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

