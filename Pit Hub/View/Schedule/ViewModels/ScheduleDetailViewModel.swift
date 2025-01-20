//
//  ScheduleDetailViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/12/25.
//

import Foundation

extension ScheduleDetailView {
    
    class ViewModel: ObservableObject{
        @Published var sessions: [Session] = []
        @Published var startDate = ""
        @Published var endDate = ""
        
        private let sessionManager = SessionManager()
        
        func fetchSessions(_ meetingKey: Int, for startDate: String){
            let date = sessionManager.convertToDate(dateString: startDate) ?? Date() // Use current date as fallback
            let year = Calendar.current.component(.year, from: date)
            sessionManager.getAllSessions(meetingKey, for_: year) { sessions in
                DispatchQueue.main.async {
                    self.sessions = sessions ?? []
                    if let startSession = self.sessions.first, let endSession = self.sessions.last {
                        self.startDate = DateUtils.formatLocalDateString(startSession.dateStart) ?? ""
                        self.endDate = DateUtils.formatLocalDateString(endSession.dateStart) ?? ""
                    }
                }
            }
        }
        
//        func getDateRange(){
//            print("getDateRange")
//            if let startSession = sessions.first, let endSession = sessions.last {
//                startDate = DateUtils.formatLocalDateString(startSession.dateStart) ?? ""
//                endDate = DateUtils.formatLocalDateString(endSession.dateStart) ?? ""
//            }
//        }
        
    }
    
}
