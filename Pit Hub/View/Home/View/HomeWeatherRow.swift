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
                VStack{
                    Text((viewModel.practiceWeather.isEmpty) ? "N/A" : "Practice")
                    Image(systemName: viewModel.practiceWeather.first?.symbolName ?? "network.slash")
                        .font(.system(size: 45))
                        .padding(2)
                    if let temperature = viewModel.practiceWeather.first?.temperature {
                        let formatter = MeasurementFormatter()
                        let temperatureString = formatter.string(from: temperature)
                        Text(temperatureString)
                    } else {
                        Text("N/A")
                    }
                }
                
                Divider()
                
                VStack{
                    Text("Qualifying")
                    Image(systemName: "cloud.heavyrain")
                        .font(.system(size: 45))
                        .padding(2)
                    Text("\(20)°C")
                }
                
                Divider()
                
                ExtractedView(raceDayWeather: viewModel.day3Weather)
                
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

struct ExtractedView: View {
    let raceDayWeather: [HourWeather]
    
    var body: some View {
        Group {
            if raceDayWeather.count == 3 {
                HStack(alignment: .bottom) {
                    ForEach(0..<3, id: \.self) { index in
                        let weather = raceDayWeather[index]
                        VStack {
                            // For the first element, display a label
                            if index == 0 {
                                Text("Race")
                            }
                            
                            Image(systemName: weather.symbolName)
                                .font(.system(size: 45))
                                .padding(2)
                            
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

