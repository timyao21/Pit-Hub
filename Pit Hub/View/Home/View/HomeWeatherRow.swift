//
//  HomeWeatherRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI

struct HomeWeatherRow: View {
    @State private var viewModel = HomeWeatherRowViewModel()
    
    init (for race: Races?) {
        self.viewModel.race = race
    }
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text((viewModel.race?.secondPractice?.date.isEmpty ?? true) ? "Sprint Quali" : "Practice")
                    Image(systemName: viewModel.day1Weather.first?.symbolName ?? "")
                        .font(.system(size: 45))
                        .padding(2)
                    if let temperature = viewModel.day1Weather.first?.temperature {
                        let formatter = MeasurementFormatter()
                        let temperatureString = formatter.string(from: temperature)
                        Text(temperatureString)
                    } else {
                        Text("N/A")
                    }
                }
                Spacer()
                VStack{
                    Text("Qualifying")
                    Image(systemName: "cloud.heavyrain")
                        .font(.system(size: 45))
                        .padding(2)
                    Text("\(20)°C")
                }
                Spacer()
                VStack{
                    Text("Race")
                    Image(systemName: "cloud.bolt.rain")
                        .font(.system(size: 45))
                        .padding(2)
                    Text("\(20)°C")
                }
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
