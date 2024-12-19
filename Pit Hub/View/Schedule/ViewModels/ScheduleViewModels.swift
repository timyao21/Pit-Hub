//
//  ScheduleViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/17/24.
//

import Foundation
import MapKit

extension ScheduleList {
    @Observable
    class ViewModel: ObservableObject{  // Renamed to PascalCase
        // MARK: - Properties
        private var scheduleManager: ScheduleManager
        
        var pastMeetings = [Meeting]()
        var upcomingMeetings = [Meeting]([
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
        ])
        
        // MARK: - Initializer
        init(scheduleManager: ScheduleManager) {
            self.scheduleManager = scheduleManager
        }
        
        // MARK: - Get all the meetings of the year
        func fetchMeetings() {
    //        scheduleManager.getUpcomingMeetings { meetings in
    //            DispatchQueue.main.async {
    //                self.upcomingMeetings = meetings ?? []
    //            }
    //        }
            
            scheduleManager.getPastMeetings { meetings in
                DispatchQueue.main.async {
                    self.pastMeetings = meetings ?? []
                }
            }
        }
        
    }
}
