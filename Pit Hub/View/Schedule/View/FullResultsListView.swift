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
                                driverFirstName: result.driver.givenName, // assuming 'Driver' has these properties
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
                            FullQualifyingResultListRowView(number: result.number, position: result.position, driverFirstName: result.driver.givenName, driverLastName: result.driver.familyName, lapTime: lapTime, constructor: result.constructor)
                            
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
                                driverFirstName: result.driver.givenName, // assuming 'Driver' has these properties
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
        VStack(alignment: .leading, spacing: 4) {
            Text(String(format: NSLocalizedString("%@ %@ result", comment: "Title for race result with race name and title"), NSLocalizedString(raceName, comment: "Race name"), NSLocalizedString(title, comment: "type of result")))
                .font(.title2)
                .fontWeight(.bold)
            HStack {
                Text(String(format: NSLocalizedString("Season: %@", comment: "Label for season"), season))
                Spacer()
                Text(String(format: NSLocalizedString("Round: %@", comment: "Label for round"), round))
            }
            .font(.headline)
            .foregroundColor(.secondary)
//            Text(time)
//                .font(.headline)
//                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}

struct FullQualifyingResultListRowView: View {
    
    let number: String
    let position: String
    let driverFirstName: String
    let driverLastName: String
    let lapTime: String
    let constructor : Constructor?
    
    private var constructorColor: Color {
        GetConstructorColor(constructorId: constructor?.constructorId ?? "")
    }
    
    var body: some View {
        HStack (alignment: .center){
            Text(position)
                .font(.title)
                .bold()
                .frame(width: 40, alignment: .center)
                .foregroundColor(PositionColor(position: position).color)

            // Driver info gets higher priority for available space.
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Text("\(NSLocalizedString(driverLastName, comment: "Driver's last name"))")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text("\(number)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(constructorColor)
                        .frame(width: 35)
                }
                Text("\(lapTime)")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .layoutPriority(1)
            
            if let constructor = constructor {
                DriverConstructorTag(constructor: constructor)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.horizontal)
    }
}





