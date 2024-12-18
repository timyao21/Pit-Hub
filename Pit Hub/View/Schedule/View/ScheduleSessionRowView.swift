//
//  ScheduleSessionRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/18/24.
//

import SwiftUI

struct ScheduleSessionRowView: View {
    var session: Session
    
    var body: some View {
        HStack {
            Text(CountryNameTranslator.translateSessions(englishAreaName: session.sessionName))
            Spacer()
            Text("\(DateUtils.getWeekday(from: session.dateStart) ?? "")")
            Text("\(DateUtils.formatLocalDateString(session.dateStart) ?? "") - \(DateUtils.formatLocalFullDateString(session.dateEnd, dateStyle: .none, timeStyle: .short) ?? "")")
        }
        .font(.custom(S.smileySans, size: 20))
    }
}

#Preview {
    ScheduleSessionRowView(session: Session(
        circuitKey: 7,
        circuitShortName: "Spa-Francorchamps",
        countryCode: "BEL",
        countryKey: 16,
        countryName: "Belgium",
        dateEnd: "2023-07-29T15:35:00+00:00",
        dateStart: "2023-07-29T15:05:00+00:00",
        gmtOffset: "02:00:00",
        location: "Spa-Francorchamps",
        meetingKey: 1216,
        sessionKey: 9140,
        sessionName: "Sprint",
        sessionType: "Race",
        year: 2023
    ))
}
