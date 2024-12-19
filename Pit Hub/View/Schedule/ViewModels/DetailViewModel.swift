//
//  DetailViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/17/24.
//

import Foundation

extension ScheduleDetail{
    @Observable
    class ViewModel: ObservableObject{
        private let sessionManager: SessionManager
        var meeting: Meeting
        var sessions = [Session]()
        var startDate = ""
        var endDate = ""
        
        
        // MARK: - Initializer
        init(sessionManager: SessionManager, meeting: Meeting) {
            self.sessionManager = sessionManager
            self.meeting = meeting
        }
        
        // MARK: - getCurGrandPrix Detail
        func getCurGrandPrixDetail() {
            print(meeting.circuitShortName)
            sessionManager.getAllSessions { [weak self] sessions in
                DispatchQueue.main.async {
                    if let sessions = sessions {
                        self?.sessions = sessions
                        if let startSession = sessions.first, let endSession = sessions.last {
                            self?.getDateRange(startSession, endSession)
                        } else {
                            print("No sessions")
                        }
                    } else {
                        print("No sessions")
                    }
                }
            }
        }
        
        func getDateRange(_ startSessions:Session, _ endSessions:Session){
            startDate = DateUtils.formatLocalDateString(startSessions.dateStart) ?? ""
            endDate = DateUtils.formatLocalDateString(endSessions.dateStart) ?? ""
        }
        
    }
}
