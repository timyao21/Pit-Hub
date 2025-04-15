//
//  HomeCalendarViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/29/25.
//

import Foundation

struct RaceCalendarDate {
    let season: String
    let round: String
    let raceName: String?
    let date: Date
    let session: String?
}

@Observable class HomeCalendarViewModel{
//    @MainActor var upcomingGP: [Races]
    @MainActor var races: [Races]
    @MainActor var days: [Date?] = []
    @MainActor var raceCalendarDate: [RaceCalendarDate] = []
    
    @MainActor
    init(for races: [Races]) {
        self.races = races
        self.days = generateDays()
        Task {
            let raceTimes = await getRaceCalendarTimes(for: races)
            raceCalendarDate = raceTimes
        }
    }
    
    private func generateDays() -> [Date?] {
        var days: [Date?] = []
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: Date())
        
        // Get January 1 and December 31 for the current year.
        var components = DateComponents(year: currentYear, month: 1, day: 1)
        guard let startDate = calendar.date(from: components) else { return days }
        components.month = 12
        components.day = 31
        guard let endDate = calendar.date(from: components) else { return days }
        
        // Compute the needed padding for the first week.
        // In the Gregorian calendar, Sunday = 1, Monday = 2, etc.
        // For a Monday-first layout, Monday should be column 0.
        // So if January 1 falls on Sunday (weekday == 1), we need 6 nils;
        // otherwise, we need (weekday - 2) nils.
        let firstWeekday = calendar.component(.weekday, from: startDate)
        let offset = firstWeekday == 1 ? 6 : firstWeekday - 2
        days.append(contentsOf: Array(repeating: nil, count: offset))
        
        // Iterate from startDate to endDate and append each date.
        var currentDate = startDate
        while currentDate <= endDate {
            days.append(currentDate)
            guard let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDate
        }
        
        return days
    }


    
//    private func generateDays() -> [Date?] {
//        var days: [Date?] = []
//        let calendar = Calendar.current
//        let currentYear = calendar.component(.year, from: Date())
//        
//        for month in 1...12 {
//            var monthDays: [Date?] = []
//            var components = DateComponents(year: currentYear, month: month, day: 1)
//            guard let firstDayOfMonth = calendar.date(from: components) else { continue }
//            
//            // Calculate the offset for the first day of the month.
//            // Gregorian: Sunday = 1, Monday = 2, ... Saturday = 7.
//            // For Monday-first: Monday should be at index 0.
//            let weekday = calendar.component(.weekday, from: firstDayOfMonth)
//            let desiredOffset = weekday == 1 ? 6 : weekday - 2
//            
//            // Pad the beginning of this month with nils.
//            for _ in 0..<desiredOffset {
//                monthDays.append(nil)
//            }
//            
//            // Append each day of the month.
//            if let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) {
//                for day in range {
//                    components.day = day
//                    if let date = calendar.date(from: components) {
//                        monthDays.append(date)
//                    }
//                }
//            }
//            
//            // Pad the end of the month to fill the final week.
//            let remainder = monthDays.count % 7
//            if remainder != 0 {
//                let padding = 7 - remainder
//                for _ in 0..<padding {
//                    monthDays.append(nil)
//                }
//            }
//            
//            // Append the month’s days to the main array.
//            days.append(contentsOf: monthDays)
//        }
//        
//        return days
//    }
    
    // Helper function to convert a date and time string into a Date.
    private func dateFromComponents(date: String?, time: String?) -> Date? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let time = time, !time.isEmpty {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
            return formatter.date(from: "\(date) \(time)")
        } else {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.date(from: date)
        }
    }
    
    // Converts each race's session (and main event) into a `RaceCalendarTime` entry.
    @MainActor
    func getRaceCalendarTimes(for races: [Races]) async -> [RaceCalendarDate] {
        var calendarTimes: [RaceCalendarDate] = []
        for race in races {
            // Main Race
            if let raceDate = dateFromComponents(date: race.date, time: race.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: raceDate,
                                                      session: "Race"))
            }
            
            // First Practice
            if let firstPractice = race.firstPractice,
               let fpDate = dateFromComponents(date: firstPractice.date, time: firstPractice.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: fpDate,
                                                      session: "FP1"))
            }
            
            // Second Practice
            if let secondPractice = race.secondPractice,
               let spDate = dateFromComponents(date: secondPractice.date, time: secondPractice.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: spDate,
                                                      session: "FP2"))
            }
            
            // Third Practice
            if let thirdPractice = race.thirdPractice,
               let tpDate = dateFromComponents(date: thirdPractice.date, time: thirdPractice.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: tpDate,
                                                      session: "FP3"))
            }
            
            // Qualifying
            if let qualifying = race.qualifying,
               let qDate = dateFromComponents(date: qualifying.date, time: qualifying.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: qDate,
                                                      session: "Quali"))
            }
            
            // Sprint Qualifying
            if let sprintQualifying = race.sprintQualifying,
               let sqDate = dateFromComponents(date: sprintQualifying.date, time: sprintQualifying.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: sqDate,
                                                      session: "S-Quali"))
            }
            
            // Sprint
            if let sprint = race.sprint,
               let sDate = dateFromComponents(date: sprint.date, time: sprint.time) {
                calendarTimes.append(RaceCalendarDate(season: race.season,
                                                      round: race.round,
                                                      raceName: race.circuit.circuitId,
                                                      date: sDate,
                                                      session: "Sprint"))
            }
        }
        return calendarTimes
    }
    
}
