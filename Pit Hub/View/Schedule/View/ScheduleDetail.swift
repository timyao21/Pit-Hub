//
//  ScheduleDetail.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleDetail: View {
    
    @StateObject private var viewModel: ViewModel
    private let sessionManager: SessionManagerOld

    // MARK: - Initializer
    init(sessionManager: SessionManagerOld, meeting: Meeting) {
        self.sessionManager = sessionManager
        _viewModel = StateObject(wrappedValue: ViewModel(sessionManager: sessionManager, meeting: meeting))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(viewModel.meeting.meetingName)
                    .font(.custom(S.smileySans, size: 20))
                Text(CountryNameTranslator.translate(englishName: viewModel.meeting.circuitShortName))
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
        }
        .padding()
        .withCustomNavigation()
        .onAppear {
            viewModel.getCurGrandPrixDetail()
        }
    }
}

#Preview {
    ScheduleDetail(sessionManager: SessionManagerOld(circuitShortName: "Sakhir", year: 2024), meeting:Meeting(
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
