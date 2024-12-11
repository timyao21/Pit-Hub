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
    @State private var meetings = [Meeting]()

    var body: some View {
        List {
            Section(header: Text("Meetings")) {
                ForEach(meetings) { meeting in
                    HStack {
                        Text(meeting.countryName) // Adjust according to Meeting properties
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Schedule")
        .onAppear {
            fetchScheduleItems()
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
