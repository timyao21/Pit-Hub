//
//  HomeWeatherRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI
import WeatherKit

struct HomeWeatherRow: View {
    
    var body: some View {
        VStack{
            PitSubtitle(for: "Weather")
            HStack{
                VStack{
                    Text("周五")
                    Image(systemName: "sun.max")
                        .font(.system(size: 45))
                        .padding(2)
                    Text("\(20)°C")
                }
                Spacer()
                VStack{
                    Text("周六")
                    Image(systemName: "cloud.heavyrain")
                        .font(.system(size: 45))
                        .padding(2)
                    Text("\(20)°C")
                }
                Spacer()
                VStack{
                    Text("周日")
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
    }
}
