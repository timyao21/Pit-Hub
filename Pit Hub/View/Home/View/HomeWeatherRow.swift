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
    
    init (for race: Races?) {
        self.viewModel.race = race
    }
    
    var body: some View {
        VStack{
            HStack{
                if !viewModel.day1Weather.isEmpty {
                    ExtractedView(title: "Practice", weatherData: viewModel.day1Weather.first!)
                }
                
                
                Divider()
                
                if !viewModel.day2Weather.isEmpty {
                    ExtractedView(title: "Practice", weatherData: viewModel.day2Weather.first!)
                }
                
                Divider()
                
                RaceWeatherRowView(raceDayWeather: viewModel.day3Weather)
                
            }
            .font(.custom(S.smileySans, size: 17))
            .frame(maxWidth: .infinity)
            .frame(height: 130)
        }
        .onAppear(){
            Task{
                await viewModel.loadWeatherData()
            }
        }
    }
}

#Preview {
    HomeWeatherRow(for: Races.sample)
}

struct RaceWeatherRowView: View {
    let raceDayWeather: [HourWeather]
    
    var body: some View {
        Group {
            if raceDayWeather.count == 3 {
                HStack(alignment: .bottom) {
                    ForEach(0..<3, id: \.self) { index in
                        let weather = raceDayWeather[index]
                        VStack(spacing: 2){
                            // For the first element, display a label
                            if index == 0 {
                                Text("Race")
                            }
                            
                            Image(systemName: weather.symbolName)
                                .font(.system(size: 45))
                                .frame(height: 55, alignment: .top)
                            
                            Text("\(Int((weather.precipitationChance * 100).rounded())) %")
                                .font(.footnote)
                            
                            Text({
                                let formatter = MeasurementFormatter()
                                formatter.numberFormatter.maximumFractionDigits = 0
                                return formatter.string(from: weather.temperature)
                            }())
                        }
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
    let title: String
    let weatherData: HourWeather
    
    var body: some View {
        VStack{
            Text(title)
            
            Image(systemName: weatherData.symbolName)
                .font(.system(size: 45))
                .frame(height: 55, alignment: .top)
            
            Text("\(Int((weatherData.precipitationChance * 100).rounded())) %")
                .font(.footnote)
            
            Text({
                let formatter = MeasurementFormatter()
                formatter.numberFormatter.maximumFractionDigits = 0
                return formatter.string(from: weatherData.temperature)
            }())
        }
    }
}
