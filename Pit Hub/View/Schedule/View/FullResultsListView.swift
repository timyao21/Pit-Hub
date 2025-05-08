//
//  FullRaceResultListView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/23/25.
//

import SwiftUI

struct FullResultsListView: View {
    
    let raceName: String
    let season: String
    let round: String
    let date: String
    let time: String
    let title: String
    let raceResult: [Results]?
    let qualifyingResult: [QualifyingResults]?
    let sprintResult: [SprintResults]?
    
    init(raceName: String, season: String, round: String, date: String, time: String, raceResult: [Results]?) {
        self.raceName = raceName
        self.title = "Race"
        self.season = season
        self.round = round
        self.date = date
        self.time = time
        self.raceResult = raceResult
        self.qualifyingResult = nil
        self.sprintResult = nil
    }
    
    init(raceName: String, season: String, round: String, date: String, time: String, qualifyingResult: [QualifyingResults]?) {
        self.raceName = raceName
        self.title = "Qualifying"
        self.season = season
        self.round = round
        self.date = date
        self.time = time
        self.raceResult = nil
        self.qualifyingResult = qualifyingResult
        self.sprintResult = nil
    }
    
    init(raceName: String, season: String, round: String, date: String, time: String, sprintResult: [SprintResults]?) {
        self.raceName = raceName
        self.title = "Sprint"
        self.season = season
        self.round = round
        self.date = date
        self.time = time
        self.raceResult = nil
        self.qualifyingResult = nil
        self.sprintResult = sprintResult
    }
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView{
                VStack {
                    // If race results are available, iterate over them directly.
                    Spacer().frame(height: 135)
                    if let raceResults = raceResult {
                        ForEach(Array(raceResults.enumerated()), id: \.element.number) {index, result in
                            FullRaceResultListRowView(
                                number: result.number,
                                position: result.position,
                                positionText: result.positionText,
                                driverFirstName: result.driver.givenName,
                                driverLastName: result.driver.familyName,
                                points: result.points,
                                status: result.status,
                                grid: result.grid,
                                constructor: result.constructor
                            )
                            
                            if index < raceResults.count - 1 { // Avoid divider after the last row
                                Divider()
                                    .frame(height: (index == 9) ? 2 : 1) // Optional: thicker divider for index 10 and 15
                                    .background((index == 9) ? Color(S.pitHubIconColor).opacity(0.5) : Color.clear)
                                    .padding(.horizontal)
                            }
                        }
                    }else if let raceResults = qualifyingResult{
                        ForEach(Array(raceResults.enumerated()), id: \.element.number) {index, result in
                            let lapTime = result.q3 ?? result.q2 ?? result.q1 ?? ""
                            // Convert lap time to seconds
                            let currentLapTime = timeInterval(from: lapTime)

                            // Get the reference lap time (previous driver's time)
                            let previousLapTime = index > 0 ? timeInterval(from: raceResults[index - 1].q3 ?? raceResults[index - 1].q2 ?? raceResults[index - 1].q1 ?? "") : nil

                            // Calculate time difference (if possible)
                            let lapTimeDifference = if let prev = previousLapTime, let curr = currentLapTime {
                                String(format: "+%.3f", curr - prev) // Show with + sign
                            } else {
                                "-" // No difference for the first driver
                            }
                            
                            FullQualifyingResultListRowView(number: result.number, position: result.position, driverFirstName: result.driver.givenName, driverLastName: result.driver.familyName, timeDiff: lapTimeDifference, lapTime: lapTime, constructor: result.constructor)
                            
                            if index < raceResults.count - 1 { // Avoid divider after the last row
                                Divider()
                                    .frame(height: (index == 9 || index == 14) ? 2 : 1) // Optional: thicker divider for index 10 and 15
                                    .background((index == 9 || index == 14) ? Color(S.pitHubIconColor).opacity(0.5) : Color.clear)
                                    .padding(.horizontal)
                            }

                        }
                    }else if let raceResults = sprintResult{
                        ForEach(Array(raceResults.enumerated()), id: \.element.number) {index, result in
                            FullRaceResultListRowView(
                                number: result.number,
                                position: result.position,
                                positionText: result.positionText,
                                driverFirstName: result.driver.givenName, // assuming 'Driver' has these properties
                                driverLastName: result.driver.familyName,
                                points: result.points,
                                status: result.status,
                                grid: result.grid,
                                constructor: result.constructor
                            )
                            
                            if index < raceResults.count - 1 { // Avoid divider after the last row
                                Divider()
                                    .frame(height: (index == 7) ? 2 : 1) // Optional: thicker divider for index 10 and 15
                                    .background((index == 7) ? Color(S.pitHubIconColor).opacity(0.5) : Color.clear)
                                    .padding(.horizontal)
                            }
                        }
                    }else {
                        Text("empty")
                    }
                }
            }
            let localTime = DateUtilities.convertUTCToLocal(date: date, time: time, format: "yyyy-MM-dd") ?? ""
            FullResultsHeaderView(raceName: raceName, season: season, round: round, time: localTime, title: title)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
        }
    }
}

// Header view displaying the title, season, round, and time.
private struct FullResultsHeaderView: View {
    let raceName: String
    let season: String
    let round: String
    let time: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            (
                Text(LocalizedStringKey(raceName))
                + Text(" ")
                + Text(LocalizedStringKey(title))
                + Text(" ")
                + Text("Result")
            )
            .font(.title2)
            .fontWeight(.bold)

            HStack {
                Text("Season: \(season)")
                Spacer()
                Text("Round: \(round)")
            }
            .font(.headline)
            .foregroundColor(.secondary)
            
            HStack{
                Text("R - Retired")
                Text("D - Disqualified")
            }
            .font(.footnote)
            .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}

private func timeInterval(from time: String) -> TimeInterval? {
    let components = time.split(separator: ":")
    guard components.count == 2,
          let minutes = Double(components[0]),
          let seconds = Double(components[1]) else {
        return nil
    }
    return (minutes * 60) + seconds
}




