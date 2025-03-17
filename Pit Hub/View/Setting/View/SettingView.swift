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
                    if indexViewModel.membership == false {
                        Button(action: {
                            seasonPassSheetIsPresented.toggle()
                        }) {
                            HStack {
                                Image(systemName: "star.fill")
                                Text("Join in Pit App Paddock Club")
                                    .fontWeight(.semibold)
                                Image(systemName: "star.fill")
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color(S.pitHubIconColor))
                        }
                    } else {
                        HStack{
                            Image(systemName: "person.crop.circle.fill")
                                .frame(width: 30)
                            Text("Pit App Paddock Club Member!")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color(S.pitHubIconColor))
                        
                        Button(action:{
                            viewModel.isShowManageSubscription.toggle()
                        }) {
                            HStack{
                                Image(systemName: "wallet.pass")
                                    .frame(width: 30)
                                Text("Manage Subscriptions")
                            }
                            .foregroundColor(.accentColor)
                        }
                        .manageSubscriptionsSheet(isPresented: $viewModel.isShowManageSubscription, subscriptionGroupID: Products.subscriptionGroups)
                    }
                }
                
                Section(header: Text("Tune Your Look")) {
                    HStack {
                        Image(systemName: "translate")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, .cyan)
                            .frame(width: 30)
                        
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
                    let aboutText: AttributedString = {
                        var string = AttributedString("Pit App is proudly crafted and developed by Junyu Yao (yjytim), and Caroline He provides art support. Follow us on all your favorite platforms, and join the fun adventure!")
                        if let range = string.range(of: "Junyu Yao") {
                            string[range].link = URL(string: "https://yjytim.com/")!
                            string[range].foregroundColor = .blue
                            string[range].underlineStyle = .single
                        }
                        return string
                    }()
                    
                    Text(aboutText)
                        .font(.body)
                    
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
        .sheet(isPresented: $seasonPassSheetIsPresented) {
            inapptest()
                .presentationDetents([.medium])
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}

