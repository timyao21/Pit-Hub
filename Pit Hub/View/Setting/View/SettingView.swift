//
//  SettingView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/26/25.
//

import SwiftUI
import StoreKit
import WeatherKit

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
    @Environment(IndexViewModel.self) private var indexViewModel
    
    @State private var viewModel = SettingViewModel()
    
    // Using AppStorage to persist user settings
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("selectedLanguage") private var selectedLanguage: AppLanguage = .chinese
    @AppStorage("selectedWeatherUnit") private var selectedWeatherUnit: WeatherUnit = .celsius
    
    
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
                    if indexViewModel.membership {
                        // Member UI
                        VStack (spacing: 8){
                            HStack {
                                Image(systemName: "wallet.pass.fill")
                                    .frame(width: 30)
                                Text("Pit App Paddock Club Member!")
                                    .fontWeight(.semibold)
                                Spacer()
                                Image(systemName: "star.square")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color(S.pitHubIconColor))
                            
                            FeatureRow(title: "Race Day Weather Forecasts", color: Color(S.pitHubIconColor))
                        }
                        
                    } else {
                        // Non-member UI presented as a button
                        
                        Button(action: {
                            indexViewModel.subscriptionSheetIsPresented.toggle()
                        }) {
                            VStack(spacing: 8) {
                                HStack {
                                    Image(systemName: "wallet.pass.fill")
                                        .frame(width: 30)
                                    
                                    Text("Join Pit App Paddock Club")
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.up.right.2")
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color(S.pitHubIconColor))
                                .padding(.bottom, 10)
                                
                                FeatureRow(title: "Race Day Weather Forecasts", color: .secondary)
                            }
                        }
                    
                    }
                }

                
                Section(header: Text("Tune Your Look")) {
//                    HStack {
//                        Image(systemName: "translate")
//                            .symbolRenderingMode(.palette)
//                            .foregroundStyle(.primary, .cyan)
//                            .frame(width: 30)
//                        
//                        Picker("Language", selection: $selectedLanguage) {
//                            ForEach(AppLanguage.allCases) { language in
//                                Text(language.displayName)
//                                    .tag(language)
//                            }
//                        }
//                    }
                    Button(action: {
                        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
                        if UIApplication.shared.canOpenURL(settingsURL) {
                            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                        }
                    }) {
                        HStack {
                            Image(systemName: "translate")
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.primary, .cyan)
                                .frame(width: 30)
                            Text("Language")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .tint(.secondary)
                        }
                    }

                    HStack{
                        Image(systemName: "iphone.app.switcher")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .indigo)
                            .frame(width: 30)
                        
                        Picker("App Theme", selection: $selectedTheme) {
                            
                            ForEach(AppTheme.allCases) { theme in
                                Text(LocalizedStringKey(theme.rawValue))
                                    .fontWeight(.semibold)
                                    .tag(theme)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical,5)
                    }
                    
                    HStack{
                        Image(systemName: "thermometer.medium")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .primary)
                            .frame(width: 30)
                        
                        Picker("Weather Unit", selection: $selectedWeatherUnit) {
                            ForEach(WeatherUnit.allCases) { unit in
                                Text(unit.rawValue)
                                    .tag(unit)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.vertical,5)
                    }
                }
                
                Section(header: Text("About Us")) {
                    VStack(alignment: .leading, spacing: 10){
                        FeatureRow(icon:"laptopcomputer", title: "Developed with passion by Junyu Yao (yjytim)", color: .primary)
                        FeatureRow(icon:"pencil.and.scribble", title: "Art direction by Caroline He", color: .primary)
                        FeatureRow(icon:"suit.heart.fill", title: "Follow our journey across platforms", color: .primary)
                    }
                    
                    Button(action: {
                        let urlString = "https://space.bilibili.com/626701417?spm_id_from=333.1365.0.0"
                        if let url = URL(string: urlString) {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image("bilibiliIcon")
                                .resizable()
                                .scaledToFit()
                                .padding(3)
                                .frame(width: 30)
                            Text("Bilibili")
                            Spacer()
                        }
                        .foregroundColor(.primary)
                    }
                    
                    Button(action: {
                        let urlString = "https://www.xiaohongshu.com/user/profile/635c844d000000001802a186"
                        if let url = URL(string: urlString) {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image("rednote")
                                .resizable()
                                .scaledToFit()
                                .padding(3)
                                .frame(width: 30)
                            Text("Rednotes")
                            Spacer()
                        }
                        .foregroundColor(.primary)
                    }
                }
                
                Section(header: Text("General")) {
                    NavigationLink(destination: About()) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.red)
                                .frame(width: 30)
                            Text("Learn More About Us")
                        }
                        .padding(.vertical, 3)
                    }
                                    
                    Button(action:{
                        let email = "yjy197@outlook.com"  // Replace with your email address
                        let subject = "Report Issue - Pit App"
                        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                        if let url = URL(string: "mailto:\(email)?subject=\(encodedSubject)") {
                            openURL(url)
                        }
                    }) {
                        HStack{
                            Image(systemName: "envelope")
                                .frame(width: 30)
                                .foregroundColor(.indigo)
                            Text("Report")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack {
                        Image(systemName: "v.circle")
                            .frame(width: 30)
                        Text("Version")
                        Spacer()
                        Text("v0.1.0")
                            .foregroundColor(.secondary)
                    }
                    AttributionView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Pit Line")
        }
        .preferredColorScheme(
            selectedTheme == .system ? nil : (selectedTheme == .light ? .light : .dark)
        )
    }
}


private struct FeatureRow: View {
    let icon: String
    let title: LocalizedStringKey
    let color: Color
    
    init(title: LocalizedStringKey, color: Color) {
        self.icon = "star.fill"
        self.title = title
        self.color = color
    }
    
    init(icon: String, title: LocalizedStringKey, color: Color) {
        self.icon = icon
        self.title = title
        self.color = color
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 30)
            Text(title)
                .fontWeight(.semibold)
            Spacer()
        }
        .font(.footnote)
        .frame(maxWidth: .infinity, alignment: .center)
        .foregroundColor(color)

    }
}
