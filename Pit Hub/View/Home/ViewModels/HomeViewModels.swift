//
//  HomeViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import Foundation

extension HomeView {
    class ViewModel: ObservableObject { // Conform to ObservableObject
        @Published var meetings: [Meeting] = []
        @Published var upcomingMeetings: [Meeting] = []
        @Published var pastMeetings: [Meeting] = []
        
        private let meetingsManager = MeetingsManager()
        
        // MARK: - load test
        func loadMeetings() {
            DispatchQueue.main.async {
                self.fetchMeetings()
                self.getUpcomingMeeting()
                self.getPastMeetings()
            }
        }
        
        // MARK: - Fetch meetings
        func fetchMeetings() {
            meetingsManager.getFullSchedule(2024) { meetings in
                DispatchQueue.main.async {
                    self.meetings = meetings ?? []
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
