//
//  DriverDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/20/25.
//

import SwiftUI

struct DriverDetailView: View {
    let driver: F1Driver
    var body: some View {
        Text(driver.lastName)
    }
}

#Preview {
    DriverDetailView(driver: F1Driver(
        id: "2024_VER",
        season: 2024,
        nameAcronym: "VER",
        fullName: "Max Verstappen",
        lastName: "Verstappen",
        firstName: "Max",
        broadcastName: "Max Verstappen",
        teamName: "Red Bull Racing",
        driverNumber: 1,
        teamColour: "#3671C6",
        countryCode: "NLD",
        raceStats: RaceStats(
            points: 425,
            wins: 15,
            podiums: 18,
            poles: 10,
            fastestLaps: 8,
            dnf:0,
            dns:0,
            dq:0
        ),
        championshipPosition: 1,
        tieBreaker: 0
    ))
}
