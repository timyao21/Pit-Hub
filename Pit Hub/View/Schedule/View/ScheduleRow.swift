//
//  ScheduleRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleRow: View {
    var gp: GrandPrix
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                HStack {
                    Text("\(CountryNameTranslator.translateFlags(countryCode: gp.countryCode)) \(gp.meetingName)")
                    
                    // 🏁 Add Sprint Badge if Sprint is true SPRINT
                    SprintBadge()
                        .opacity(gp.sprint ? 1 : 0) // Hides the view when `gp.sprint` is false
                }
                Text(CountryNameTranslator.translate(englishName: gp.circuitShortName))
                    .font(.custom(S.smileySans, size: 25))
                    .padding([.top, .bottom],1)
                if let localTime = DateUtils.formatLocalFullDateString(gp.dateStart) {
                    Text("\(NSLocalizedString("Time", comment: "Time"))：\(localTime)")
                } else {
                    Text("Invalid Date")
                }
            }
            .font(.custom(S.smileySans, size: 18))
            Spacer()
            Image(gp.circuitShortName)
                .resizable()
                .renderingMode(.template) // Makes the image render as a template
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(Color("circuitColor")) // Applies the color to the image
            Image(systemName: "arrowshape.right")
                .imageScale(.medium)
        }
        .cornerRadius(10) // Rounds the corners of the background
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ScheduleRow(gp: GrandPrix(
        circuitKey: 1,
        circuitShortName: "Albert Park",
        countryCode: "AUS",
        countryKey: 13,
        countryName: "Australia",
        dateStart: "2024-03-24T05:00:00+00:00",
        gmtOffset: "+11:00",
        location: "Melbourne",
        meetingCode: "AUS24",
        meetingKey: 101,
        meetingName: "Australian Grand Prix",
        meetingOfficialName: "Formula 1 Rolex Australian Grand Prix 2024",
        sprint: true,
        year: 2024
    ))
}

