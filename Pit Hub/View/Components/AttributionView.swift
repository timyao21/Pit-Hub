//
//  AttributionView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/16/25.
//

import SwiftUI
import WeatherKit

struct AttributionView: View {
    @AppStorage("selectedTheme") private var selectedTheme: AppTheme = .system
    let weatherManager = WeatherManager.shared
    @State private var attribution: WeatherAttribution?
    var body: some View {
        VStack{
            if let attribution {
                
                // Choose the correct URL based on the selected theme
                let logoURL: URL? = {
                    switch selectedTheme {
                    case .dark:
                        return attribution.combinedMarkDarkURL
                    default:
                        return attribution.combinedMarkLightURL
                    }
                }()
                
                if let url = logoURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 13)
                    } placeholder: {
                        ProgressView()
                    }
                    Text("[\(attribution.serviceName)](\(attribution.legalPageURL.absoluteString))")
                        .font(.caption)
                        .foregroundColor(.blue)
                } else {
                    Text("Attribution logo unavailable")
                        .foregroundColor(.secondary)
                }
            }else{
                ProgressView("Loading attribution...")
            }
        }
        .task {
            Task.detached { @MainActor in
                attribution = await weatherManager.weatherAttribution()
            }
        }
    }
}

#Preview {
    AttributionView()
}
