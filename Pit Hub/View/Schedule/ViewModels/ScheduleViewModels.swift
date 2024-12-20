//
//  ScheduleViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/17/24.
//

import Foundation
import MapKit

extension ScheduleListView {
    class ViewModel: ObservableObject{
        // MARK: - Properties
        private let meetingsManager = MeetingsManager()
        
        @Published var meetings: [Meeting] = []
        @Published var upcomingMeetings: [Meeting] = []
        @Published var pastMeetings: [Meeting] = []
        @Published var curYear: Int = Calendar.current.component(.year, from: Date())
        
        // MARK: - Fetch meetings
        func fetchMeetings() {
            meetingsManager.getFullSchedule(curYear) { meetings in
                DispatchQueue.main.async {
                    self.meetings = meetings ?? []
                    self.getUpcomingMeeting()
                    self.getPastMeetings()
                }
            }
        }
        
        // MARK: - get the Upcoming Meetings
        func getUpcomingMeeting() {
            DispatchQueue.main.async {
                self.upcomingMeetings = self.meetingsManager.getUpcomingMeetings(from: self.meetings)
            }
        }
        
        // MARK: - get the Past Meetings
        func getPastMeetings() {
            DispatchQueue.main.async {
                self.pastMeetings = self.meetingsManager.getPastMeetings(from: self.meetings)
            }
        }
        
    }
}
