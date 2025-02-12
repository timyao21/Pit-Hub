//
//  HomeViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import Foundation

extension HomeViewOld {
    class ViewModel: ObservableObject { // Conform to ObservableObject
        @Published var meetings: [Meeting] = []
        @Published var upcomingMeetings: [Meeting] = []
        @Published var pastMeetings: [Meeting] = []
//        @Published var curYear: Int = Calendar.current.component(.year, from: Date())
        @Published var curYear: Int = 2024
        
        private let meetingsManager = MeetingsManager()
        
        // MARK: - load test
        func loadMeetings() {
            self.fetchMeetings()
        }
        
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
