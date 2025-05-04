//
//  HomeWeatherRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI
import WeatherKit

struct HomeWeatherRow: View {
    
    // input param
    let race: Races
    
    // Hold the view‑model
    @State private var viewModel: ViewModel
    
    init(for race: Races){
        self.race = race
        _viewModel = State(wrappedValue: ViewModel(race: race))
    }
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack{
            TabView(selection: $selectedTab){
                RaceWeatherRowView(raceDayWeather: viewModel.raceWeather)
                    .tag(0)
                if !viewModel.qualifyingWeather.isEmpty {
                    HStack(alignment: .bottom, spacing: 8){
                        if let fp1Weather = viewModel.fp1Weather.first {
                            WeatherCol(title: "FP1", weatherData: fp1Weather)
                            Divider()
                                .padding(3)
                        }
                        
                        if let sprintQualiWeather = viewModel.sprintQualiWeather.first {
                            WeatherCol(title: "Sprint Quali", weatherData: sprintQualiWeather)
                            Divider()
                                .padding(3)
                        }
                        
                        if let fp2Weather = viewModel.fp2Weather.first {
                            WeatherCol(title: "FP2", weatherData: fp2Weather)
                            Divider()
                                .padding(3)
                        }
                        
                        if let spWeather = viewModel.sprintWeather.first {
                            WeatherCol(title: "Sprint", weatherData: spWeather)
                            Divider()
                                .padding(3)
                        }
                        
                        if let fp3Weather = viewModel.fp3Weather.first {
                            WeatherCol(title: "FP3", weatherData: fp3Weather)
                            Divider()
                                .padding(3)
                        }
                        
                        if let qualifyingWeather = viewModel.qualifyingWeather.first {
                            WeatherCol(title: "Qualifying", weatherData: qualifyingWeather)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .tag(1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(minHeight: 133)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        CustomPageIndicator(selectedTab: $selectedTab, numberOfPages: viewModel.qualifyingWeather.isEmpty ? 0: 2)
    }
}

struct RaceWeatherRowView: View {
    let raceDayWeather: [HourWeather]
    
    var body: some View {
        Group {
            if raceDayWeather.count == 4 {
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(0..<4, id: \.self) { index in
                        WeatherCol(title: index == 0 ? "Race" : "+ \(index) h", weatherData: raceDayWeather[index])
                    }
                }
            } else {
                Text("Weather data only available 10 days before the race Day")
                    .frame(width: 150)
            }
        }
    }
}


struct WeatherCol: View {
    @AppStorage("selectedWeatherUnit") private var selectedWeatherUnit: WeatherUnit = .celsius
    let title: LocalizedStringKey
    let weatherData: HourWeather
    
    var body: some View {
        VStack(spacing: 2){
            Text(title)
                .font(.footnote)
                .fontWeight(.bold)
                .padding(.bottom, 5)
            
            Image(systemName: "\(weatherData.symbolName)")
                .font(.system(size: 45))
                .frame(height: 60, alignment: .top)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.primary, weatherData.precipitationChance == 0 ? Color.orange : Color.blue)   
            
            Text("\(Int((weatherData.precipitationChance * 100).rounded())) %")
                .font(.footnote)
                .padding(.bottom, 3)
            Text({
                let formatter = MeasurementFormatter()
                formatter.unitOptions = .providedUnit  // Use the unit provided by the measurement
                formatter.numberFormatter.maximumFractionDigits = 0
                var temperature = weatherData.temperature
                // Convert temperature to Fahrenheit if selected
                if selectedWeatherUnit == .fahrenheit {
                    temperature = temperature.converted(to: .fahrenheit)
                }
                return formatter.string(from: temperature)
            }())
            .fontWeight(.medium)

        }
        .frame(maxWidth: .infinity)
    }
    
}


