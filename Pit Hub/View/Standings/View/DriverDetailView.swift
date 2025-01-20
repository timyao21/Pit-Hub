//
//  DriverDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/20/25.
//

import SwiftUI

struct DriverDetailView: View {
    let driver: Driver
    var body: some View {
        Text(driver.lastName)
    }
}

#Preview {
    DriverDetailView(driver: Driver(
        id: UUID(),
        broadcastName: "M VERSTAPPEN",
        countryCode: "NED",
        driverNumber: 1,
        firstName: "Max",
        fullName: "Max Verstappen",
        lastName: "Verstappen",
        nameAcronym: "VER",
        points: 395,
        teamColour: "3671C6",
        teamName: "Red Bull Racing"
    ))
}
