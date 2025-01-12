//
//  HomeWeatherRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import SwiftUI
import WeatherKit

struct HomeWeatherRow: View {
    
    var meeting: Meeting
    
//    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack{
            Text("比赛天气")
                .font(.custom(S.smileySans, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color(S.pitHubIconColor))
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

#Preview {
    HomeWeatherRow(meeting:Meeting(
        circuitKey: 63,
        circuitShortName: "Sakhir",
        countryCode: "SGP",
        countryKey: 157,
        countryName: "Bahrain",
        dateStart: "2023-09-19T09:30:00+00:00",
        gmtOffset: "08:00:00",
        location: "Northamptonshire",
        meetingKey: 1219,
        meetingName: "Bahrain Grand Prix",
        meetingOfficialName: "FORMULA 1 SINGAPORE AIRLINES SINGAPORE GRAND PRIX 2023",
        year: 2023
    ))
}
