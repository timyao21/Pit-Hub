//
//  HomeRaceRowModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import Foundation

extension HomeRaceRow{
    
    class ViewModel: ObservableObject{
        @Published var sessions: [Session] = []
        @Published var filteredSessions: [Session] = []
        
        private let sessionManager = SessionManager()
        
        func fetchSessions(_ meetingKey: Int, for startDate: String){
            let date = sessionManager.convertToDate(dateString: startDate) ?? Date() // Use current date as fallback
            let year = Calendar.current.component(.year, from: date)
            sessionManager.getAllSessions(meetingKey, for_: year) { sessions in
                DispatchQueue.main.async {
                    self.sessions = sessions ?? []
                    print(self.sessions)
                    self.filterRaceAndQualifyingSessions()
                }
            }
        }
        
        func filterRaceAndQualifyingSessions(){
            self.filteredSessions = sessions.filter { $0.sessionType == "Race" || $0.sessionType == "Qualifying" }
        }
        
    }
}
