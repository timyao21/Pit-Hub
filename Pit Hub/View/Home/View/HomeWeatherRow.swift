//
//  HomeWeatherRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI
import WeatherKit

struct HomeWeatherRow: View {
    @State private var viewModel = HomeWeatherRowViewModel()
    @State private var selectedTab: Int = 0
    
    init(for race: Races?) {
        self.viewModel.race = race
    }
    
    var body: some View {
        VStack{
            TabView(selection: $selectedTab){
                RaceWeatherRowView(raceDayWeather: viewModel.raceWeather)
                    .tag(0)
                
                HStack(alignment: .bottom, spacing: 8){
                    if let fp1Weather = viewModel.fp1Weather {
                        ExtractedView(title: "FP1", weatherData: fp1Weather)
                        Divider()
                            .padding(3)
                    }
                    
                    if let sprintQualiWeather = viewModel.sprintQualiWeather.first {
                        ExtractedView(title: "Sprint Quali", weatherData: sprintQualiWeather)
                        Divider()
                            .padding(3)
                    }
                    
                    if let fp2Weather = viewModel.secondPracticeWeather.first {
                        ExtractedView(title: "FP2", weatherData: fp2Weather)
                        Divider()
                            .padding(3)
                    }
                    
                    if let fp3Weather = viewModel.thirdPracticeWeather.first {
                        ExtractedView(title: "FP3", weatherData: fp3Weather)
                        Divider()
                            .padding(3)
                    }
                    
                    if let qualifyingWeather = viewModel.qualifyingWeather.first {
                        ExtractedView(title: "Qualifying", weatherData: qualifyingWeather)
                    }
                }
                .frame(maxWidth: .infinity)
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onAppear {
                Task {
                    await viewModel.loadWeatherData()
                }
            }
            .frame(minHeight: 133)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        CustomPageIndicator(selectedTab: $selectedTab, numberOfPages: 2)
    }
}


//#Preview {
//    HomeWeatherRow(for: Races.sample)
//}

#Preview {
    BottomNavBarIndexView()
}

struct RaceWeatherRowView: View {
    let raceDayWeather: [HourWeather]
    
    var body: some View {
        Group {
            if raceDayWeather.count == 4 {
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(0..<4, id: \.self) { index in
                        ExtractedView(title: index == 0 ? "Race" : "", weatherData: raceDayWeather[index])
//                            .frame(maxWidth: .infinity)
                    }
                }
            } else {
                Text("Unable to fetch Race weather data")
                    .frame(width: 150)
            }
        }
    }
}


struct ExtractedView: View {
    let title: LocalizedStringKey
    let weatherData: HourWeather
    
    var body: some View {
        VStack(spacing: 2){
            Text(title)
                .font(.footnote)
                .fontWeight(.bold)
            
            Image(systemName: weatherData.symbolName)
                .font(.system(size: 45))
                .frame(height: 60, alignment: .top)
            
            Text("\(Int((weatherData.precipitationChance * 100).rounded())) %")
                .font(.footnote)
                .padding(.bottom, 3)
            
            Text({
                let formatter = MeasurementFormatter()
                formatter.numberFormatter.maximumFractionDigits = 0
                return formatter.string(from: weatherData.temperature)
            }())
            .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}


