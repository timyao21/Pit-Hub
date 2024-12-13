//
//  ScheduleDetail.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleDetail: View {
    var meeting: Meeting
    var body: some View {
        ZStack{
            VStack{
                Text(CountryNameTranslator.translate(englishName: meeting.circuitShortName))
            }
        }
    }
}

#Preview {
    ScheduleDetail(meeting:Meeting(
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
