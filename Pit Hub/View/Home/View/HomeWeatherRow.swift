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
                    Text((viewModel.race?.secondPractice?.date.isEmpty ?? true) ? "Practice" : "Sprint Quali")
                    Image(systemName: "sun.max")
                        .font(.system(size: 45))
                        .padding(2)
                    Text("\(20)°C")
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
                await viewModel.fetchWeather()
            }
        }
    }
}

#Preview {
    HomeWeatherRow(for: Races.sample)
}
