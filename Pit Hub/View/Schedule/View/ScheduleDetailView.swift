//
//  ScheduleDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/12/25.
//

import SwiftUI

struct ScheduleDetailView: View {
    
    var meeting: Meeting
    
    @StateObject var viewModel = ViewModel()
    @State var displaySessions:  [Session] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(meeting.meetingName)
                    .font(.custom(S.smileySans, size: 20))
                Text(CountryNameTranslator.translate(englishName: meeting.circuitShortName))
                    .font(.custom(S.smileySans, size: 35))
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                Text("\(viewModel.startDate) - \(viewModel.endDate)")
                    .font(.custom(S.smileySans, size: 25))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            List(viewModel.sessions) { session in
                ScheduleSessionRowView(session: session)
            }
            .listStyle(.plain)
            Image(meeting.circuitShortName)
                .resizable()
                .renderingMode(.template) // Makes the image render as a template
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .top)
                .foregroundColor(Color("circuitColor")) // Applies the color to the image
            Spacer()
        }
        .withCustomNavigation()
        .padding()
        .onAppear {
            viewModel.fetchSessions(meeting.meetingKey, for: meeting.dateStart)
        }
    }
}

#Preview {
    ScheduleDetailView(meeting:Meeting(
        circuitKey: 63,
        circuitShortName: "Las Vegas",
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
