//
//  ScheduleDetail.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleDetail: View {
    
    var sessionManager: SessionManager
    var meeting: Meeting
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(meeting.meetingName)
                    .font(.custom(S.smileySans, size: 20)) // Set the desired font size
                Text(CountryNameTranslator.translate(englishName: meeting.circuitShortName))
                    .font(.custom(S.smileySans, size: 35))
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                let dateRange = getDataRange(date: meeting.dateStart)
                if let startDateString = dateRange.startDate,
                   let endDateString = dateRange.endDate {
                    Text("\(startDateString) - \(endDateString)")
                        .font(.custom(S.smileySans, size: 25))
                } else {
                    Text("Invalid Date")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .padding()
        .withCustomNavigation()
        .onAppear {
            print(getDataRange(date: meeting.dateStart))
            getCurGrandPrixDetail()
        }
    }
    
    // MARK: - get the data range
    func getDataRange(date: String) -> (startDate: String?, endDate: String?) {
        let calendar = Calendar.current

        // Convert the input ISO date string to a local Date
        guard let currentDate = TimeModel(isoDateString: date).toLocalDate() else {
            print("Invalid ISO date string: \(date)")
            return (nil, nil)
        }

        // Define the start date (current date)
        let startDate = currentDate

        // Define the end date (e.g., 7 days from the start date)
        guard let endDate = calendar.date(byAdding: .day, value: 3, to: currentDate) else {
            print("Failed to calculate end date")
            return (nil, nil)
        }

        // Format the dates for display
        let localDateFormatter = DateFormatter()
        localDateFormatter.dateStyle = .short
        localDateFormatter.timeStyle = .none

        return (localDateFormatter.string(from: startDate), localDateFormatter.string(from: endDate))
    }
    
    // MARK: - getCurGrandPrix Detail
    func getCurGrandPrixDetail() {
        print(meeting.circuitShortName)
        sessionManager.getAllSessions { sessions in
            print(sessions)
        }
    }

}

#Preview {
    ScheduleDetail(sessionManager: SessionManager(circuitShortName: "Sakhir", year: 2024), meeting:Meeting(
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
