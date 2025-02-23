//
//  FullRaceResultListView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/23/25.
//

import SwiftUI

struct FullRaceResultListView: View {
    
    let raceName: String
    let season: String
    let round: String
    let time: String
    let title: String
    let raceResult: [Results]?
    let qualifyingResult: [QualifyingResults]?
    
    init(raceName: String, season: String, round: String, time: String, raceResult: [Results]?) {
        self.raceName = raceName
        self.title = "Race"
        self.season = season
        self.round = round
        self.time = time
        self.raceResult = raceResult
        self.qualifyingResult = nil
    }
    
    init(raceName: String, season: String, round: String, time: String, qualifyingResult: [QualifyingResults]?) {
        self.raceName = raceName
        self.title = "Qualifying"
        self.season = season
        self.round = round
        self.time = time
        self.raceResult = nil
        self.qualifyingResult = qualifyingResult
    }
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView{
                VStack {
                    // If race results are available, iterate over them directly.
                    Spacer().frame(height: 120)
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
                            
                            if index < raceResults.count - 1 { // Avoids divider after the last row
                                Divider()
                                    .padding(.horizontal)
                            }
                        }
                    }
                    else {
                        Text("empty")
                    }
                }
            }
            FullRaceResultHeaderView(raceName: raceName, season: season, round: round, time: time, title: title)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
        }
    }
}

// Header view displaying the title, season, round, and time.
private struct FullRaceResultHeaderView: View {
    let raceName: String
    let season: String
    let round: String
    let time: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(raceName) \(title)")
                .font(.title3)
                .fontWeight(.bold)
            HStack {
                Text("Season: \(season)")
                Spacer()
                Text("Round: \(round)")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            Text(time)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 120)
    }
}


// MARK: - Row view
private struct FullRaceResultListRowView: View {
    
    let number: String
    let position: String
    let driverFirstName: String
    let driverLastName: String
    let points: String
    let status: String?
    let grid: String?
    let constructor: Constructor?

    
    var body: some View {
        HStack {
            Text(position)
                .font(.title)
                .frame(width: 40, alignment: .leading)
                .foregroundColor(position == "1" ? .orange : position == "2" ? .gray : position == "3" ? .brown : .primary.opacity(0.8))
            
            VStack(alignment: .leading){
                HStack {
                    HStack(spacing: 4) {
                        Text("\(number)")
                            .font(.custom(S.orbitron, size: 18))
                            .bold()
                            .foregroundColor(GetConstructorColor(constructorId: constructor?.constructorId ?? ""))
                            .frame(width: 35)
                            .truncationMode(.tail)
                        Text("\(driverFirstName) \(driverLastName)")
                            .font(.headline)
                            .lineLimit(1)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                
                HStack{
                    if let grid = grid, let gridInt = Int(grid), let posInt = Int(position) {
                        HStack(spacing: 3) {
                            GridDiffView(start: gridInt, finish: posInt)
                            Text("Start: \(grid)")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        .frame(height: 20)
                    }
                }
            }
            VStack{
                if let constructor = constructor {
                    DriverConstructorTag(constructor: constructor)
                        .frame(minWidth: 100, maxWidth: .infinity, alignment: .trailing)
                }
                Text("+ \(points) pts")
                    .font(.body)
                    .frame(minWidth: 100, maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
    }
}

private struct GridDiffView: View {
    let start: Int
    let finish: Int

    var body: some View {
        // Calculate the difference
        let diff = start - finish
        
        HStack(spacing: 3) {
            if diff == 0 {
                Text("--")
                    .font(.caption)
                    .foregroundColor(.gray)
            } else {
                // Choose arrow based on whether diff is negative or positive.
                // Negative diff -> arrow down, Positive diff -> arrow up.
                Image(systemName: diff < 0 ? "arrowtriangle.down.fill" : "arrowtriangle.up.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.secondary)
                
                // Optionally display the absolute difference value
                Text(String(abs(diff)))
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 30)
    }
}


