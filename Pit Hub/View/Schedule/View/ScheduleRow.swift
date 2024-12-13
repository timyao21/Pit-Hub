//
//  ScheduleRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleRow: View {
    var meeting: Meeting
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text(meeting.meetingName)
                Text(CountryNameTranslator.translate(englishName: meeting.circuitShortName))
                    .font(.custom(S.smileySans, size: 25))
                    .padding([.top, .bottom],1)
                if let localTime = TimeModel(isoDateString: meeting.dateStart).toLocalDate() {
                    Text("时间：\(localTime)")
                } else {
                    Text("Invalid Date")
                }
            }
            .font(.custom(S.smileySans, size: 18))
            Spacer()
            Image(S.pitIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
    }
}

#Preview {
    Group {
        ScheduleRow(meeting:Meeting(
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
}
