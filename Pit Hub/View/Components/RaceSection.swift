//
//  HomeRaceRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct RaceSection: View {
    @Environment(\.locale) var locale
    let race: Races?
    //    init the race section
    init(for race: Races?) {
        self.race = race
    }
    
    var body: some View {
        Group {
            if let race = race {
                VStack (spacing: 6){
                    
                    // Race title and date with circuit image
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Text(CountryFlags.flag(for: race.circuit.location.country))
                                Text(LocalizedStringKey(race.circuit.circuitName))
                                    .font(.custom(S.smileySans, size: 18))
                            }
                            
                            Text(LocalizedStringKey(race.raceName))
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack{
                                if let localDate = DateUtilities.convertUTCToLocal(
                                    date: race.date,
                                    time: race.time!,
                                    format: DateUtilities.localizedDateFormat(for: "yyyy-MM-dd", language: locale.language.languageCode?.identifier ?? "en")
                                ) {
                                    Text("\(localDate)")
                                        .font(.headline)
                                }
                                
                                if race.sprint != nil {
                                    SprintBadge()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(race.circuit.circuitId)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 125)
                            .foregroundColor(Color("circuitColor"))
                    }
                    
                    // Sessions list, grouped by date
                    let groupedSessions = Dictionary(grouping: raceSessions(for: race)) { $0.date }
                    
                    VStack(spacing: 10) {
                        let sortedDates = groupedSessions.keys.sorted()
                        ForEach(Array(sortedDates.enumerated()), id: \.element) {index, date in
                            VStack(alignment: .leading, spacing: 5) {
                                // Date header (format as needed)
                                HStack{
                                    if let weekday = weekdayString(from: date) {
                                        Text(weekday)
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                    }
                                    if index == 0 {
                                        Text("All times are in your local time zone")
                                            .font(.footnote)
                                            .foregroundColor(.secondary)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                
                                ForEach(groupedSessions[date]!, id: \.title) { session in
                                    RaceSessionList(
                                        title: session.title,
                                        date: session.date,
                                        time: session.time
                                    )
                                }
                                Divider()
                            }
                        }
                    }
                    
                    
                }
            } else {
                // Provide a fallback view when race is nil
                Text("No race information available.")
            }
        }
    }
    
    // Helper to gather all available sessions into an array
    private func raceSessions(for race: Races) -> [RaceSession] {
        var sessions: [RaceSession] = []
        if let fp1 = race.firstPractice { sessions.append(.init(title: "FP1", date: fp1.date, time: fp1.time ?? "")) }
        if let fp2 = race.secondPractice { sessions.append(.init(title: "FP2", date: fp2.date, time: fp2.time ?? "")) }
        if let sprintQuali = race.sprintQualifying { sessions.append(.init(title: "Sprint Quali", date: sprintQuali.date, time: sprintQuali.time ?? "")) }
        if let fp3 = race.thirdPractice { sessions.append(.init(title: "FP3", date: fp3.date, time: fp3.time ?? "")) }
        if let sprint = race.sprint { sessions.append(.init(title: "Sprint", date: sprint.date, time: sprint.time ?? "")) }
        if let qualifying = race.qualifying { sessions.append(.init(title: "Qualifying", date: qualifying.date, time: qualifying.time ?? "")) }
        // "Race" is always present
        sessions.append(.init(title: "Race", date: race.date, time: race.time ?? ""))
        return sessions
    }
    
    //    get the weekdayString
    private func weekdayString(from dateString: String, format: String = "yyyy-MM-dd") -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "EEEE" // Full name (e.g., "Monday")
            return formatter.string(from: date)
        }
        return nil
    }
    
    // Helper struct for session data
    private struct RaceSession {
        let title: String
        let date: String
        let time: String
    }
    
}

struct RaceSessionList: View {
    @Environment(\.locale) var locale
    let title: String
    let date: String
    let time: String
    
    var body: some View {
        HStack{
            Text(LocalizedStringKey(title))
                .font(.body)
                .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            if let localDate = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: DateUtilities.localizedDateFormat(for: "MM-dd", language: locale.language.languageCode?.identifier ?? "en")) {
                Text("\(localDate)")
                    .font(.body)
                    .frame(width: 120, alignment: .center)
            }else {
                Text("UTC: \(date)")
                    .font(.footnote)
                    .frame(width: 120, alignment: .center)
            }
            
            Spacer()
            
            if let localTime = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: "HH:mm") {
                Text("\(localTime)")
                    .font(.body)
                    .frame(width: 100, alignment: .trailing)
            }else {
                Text("UTC: \(time)")
                    .font(.body)
                    .frame(width: 100, alignment: .trailing)
            }
        }
        .padding(3)
    }
}
