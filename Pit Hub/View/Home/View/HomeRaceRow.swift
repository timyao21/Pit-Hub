//
//  HomeRaceRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct HomeRaceRow: View {
    
    var meeting: Meeting
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        HStack{
            Text("\(CountryNameTranslator.translate(englishName: meeting.circuitShortName))")
            Spacer()
        }
        .font(.custom(S.smileySans, size: 20))
        .onAppear {
            viewModel.fetchSessions(meeting.meetingKey, for: meeting.dateStart)
        }
    }
}

#Preview {
    HomeRaceRow(meeting:Meeting(
        circuitKey: 63,
        circuitShortName: "Sakhir",
        countryCode: "SGP",
        countryKey: 157,
        countryName: "Bahrain",
        dateStart: "2023-09-19T09:30:00+00:00",
        gmtOffset: "08:00:00",
        location: "Marina Bay",
        meetingKey: 1219,
        meetingName: "Bahrain Grand Prix",
        meetingOfficialName: "FORMULA 1 SINGAPORE AIRLINES SINGAPORE GRAND PRIX 2023",
        year: 2023
    ))
}
