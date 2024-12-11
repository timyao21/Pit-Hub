//
//  ScheduleView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ScheduleItem: Identifiable {
    var id = UUID()
    var curYear: Int
}

struct ScheduleView: View {
    @State private var scheduleItems = [ScheduleItem]()
    @State private var meetings = [
        Meeting(
            circuitKey: 61,
            circuitShortName: "Singapore",
            countryCode: "SGP",
            countryKey: 157,
            countryName: "Singapore",
            dateStart: "2023-09-15T09:30:00+00:00",
            gmtOffset: "08:00:00",
            location: "Marina Bay",
            meetingKey: 1219,
            meetingName: "Singapore Grand Prix",
            meetingOfficialName: "FORMULA 1 SINGAPORE AIRLINES SINGAPORE GRAND PRIX 2023",
            year: 2023
        ),
        Meeting(
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
        )
    ]
    
//    @State private var meetings = [Meeting]()

    var body: some View {
        List {
            Section(header: Text("F1 赛历")) {
                ForEach(meetings) { meeting in
                    HStack {
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
                        .font(.custom(S.smileySans, size: 15))
                        Spacer()
                    }
                    .padding(.all, 5)
                }
            }
        }
        .navigationTitle("Schedule")
        .onAppear {
//            fetchScheduleItems()
        }
    }

    // MARK: - Fetch Cur Year Schedule Items
    private func fetchScheduleItems() {
        let db = Firestore.firestore()
        db.collection("info").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if snapshot != nil {
                    let scheduleMode = ScheduleMode(year: snapshot!.documents.first?.data()["curYear"] as? Int ?? 0)
                    scheduleMode.getFullSchedule { fetchedMeetings in
                        if let fetchedMeetings = fetchedMeetings {
                            DispatchQueue.main.async {
                                self.meetings = fetchedMeetings
                            }
//                            print("Meetings: \(fetchedMeetings)")
                        } else {
                            print("No meetings found or error occurred")
                        }
                    }
                }
            }
        }
    }
    
    
    
}

#Preview {
    ScheduleView()
}
