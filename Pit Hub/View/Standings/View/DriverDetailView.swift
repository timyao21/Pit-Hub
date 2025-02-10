//
//  DriverDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/20/25.
//

import SwiftUI

struct DriverDetailView: View {
    let driver: F1Driver
    let position: Int
    let rows = Array(repeating: GridItem(.fixed(88)), count: 1)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Driver Name & Number
            HStack(spacing: 10) {
                Text("\(driver.driverNumber)")
                    .font(.custom(S.smileySans, size: 30))
                    .foregroundColor(Color(hex: driver.teamColour))
                Text("\(driver.nameAcronym)")
                    .font(.custom(S.smileySans, size: 30))
                    .foregroundColor(Color(hex: driver.teamColour))
                
                Text("\(NSLocalizedString(driver.firstName, comment: "Driver first name")) \(NSLocalizedString(driver.lastName, comment: "Driver last name"))")
                    .font(.custom(S.smileySans, size: 28))
                
                Spacer()
            }
            
            // Team Name
            HStack {
                Text("\(NSLocalizedString(driver.teamName, comment: "Driver Team Name"))")
                    .font(.headline)
                Text(driver.teamName)
                    .font(.headline)
            }
            .foregroundColor(Color(hex: driver.teamColour).opacity(0.7))
            
            // Driver Stats
            VStack(alignment: .leading, spacing: 10) {
                Text(String(format: NSLocalizedString("%d Season - Driver Stats", comment: "Driver stats for a specific season"), driver.season))
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                // Points Stat
                StatPointsView(
                    title: "Points",
                    value: "\(driver.raceStats.points)",
                    color: Color(S.pitHubIconColor),
                    icon: "chart.bar.xaxis",
                    positions: position
                )
                .frame(height: 120)
                
                // Horizontal Scrollable Stats
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 10) {
                        StatView(title: "Wins", value: "\(driver.raceStats.wins)", color: .indigo, icon: "trophy.fill")
                        StatView(title: "Podiums", value: "\(driver.raceStats.podiums)", color: .brown, icon: "flag.checkered")
                        StatView(title: "Poles", value: "\(driver.raceStats.poles)", color: .blue, icon: "flag.checkered") // 🏁 Checkered flag for pole positions
                            StatView(title: "Fastest Laps", value: "\(driver.raceStats.fastestLaps)", color: .red, icon: "speedometer") // ⏱ Speedometer for fastest laps
                            StatView(title: "Did Not Finish", value: "\(driver.raceStats.dnf)", color: .gray, icon: "xmark.octagon.fill") // ❌ Octagon stop for DNF
                    }
                    .padding(.vertical, 5)
                }
            }
            
            DriverPerformanceGraphView(driverID: driver.id)
            Spacer()
            
        }
        .padding()
    }
}

// MARK: - Stat View (Simplified)
struct StatPointsView: View {
    let title: String
    let value: String
    let color: Color?
    let icon: String
    let positions: Int?
    
    var body: some View {
        HStack(spacing: 12) { // Space between icon & text
            ZStack {
                Circle()
                    .fill(color?.opacity(0.3) ?? Color.gray.opacity(0.2)) // Circular background
                    .frame(width: 60, height: 60) // Adjusted size
                
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30) // Icon inside the circle
                    .foregroundColor(color ?? .primary)
            }
            
            VStack(alignment: .leading, spacing: 6) { // Left-align text
                HStack (alignment: .lastTextBaseline){
                    Text(value)
                        .font(.system(size: 32, weight: .bold)) // Adjusted for readability
                    Text(NSLocalizedString(title, comment: "Stat title"))
                        .font(.system(size: 20, weight: .bold))
                }
                .foregroundColor(color ?? .primary)
                
                
                if let positions = positions {
                    Text("\(NSLocalizedString("Current Standing", comment: "Stat position title")): \(positions)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(color ?? .primary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Ensures text alignment
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading) // Full frame left-aligned
        .background(
            LinearGradient(
                gradient: Gradient(colors: [
                    (color?.opacity(0.2) ?? Color.gray.opacity(0.2)), // Start color
                    (color?.opacity(0.0) ?? Color.clear) // Fades to transparent
                ]),
                startPoint: .leading,
                endPoint: .trailing // Adjust direction as needed
            )
        )
        .cornerRadius(15)
    }
}

// MARK: - Stat View (Simplified)
struct StatView: View {
    let title: String
    let value: String
    let color: Color?
    let icon: String // SF Symbol icon name
    
    var body: some View {
        VStack {
            HStack {
                
                    ZStack {
                        Circle()
                            .fill(color?.opacity(0.3) ?? Color.gray.opacity(0.2)) // Circular background
                            .frame(width: 40, height: 40) // Adjust size as needed
                        
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20) // Adjust icon size inside the circle
                            .foregroundColor(color ?? .primary)
                    }
                
                VStack {
                    Text("\(NSLocalizedString(title, comment: "StatView title"))")
                        .font(.footnote)
                        .bold(true)
                        .foregroundColor(color?.opacity(0.7) ?? .secondary)
                        .dynamicTypeSize(.small ... .xLarge)
                    Text(value)
                        .font(.system(size: 22, weight: .bold)) // Adjusted for readability
                        .foregroundColor(color ?? .primary)
                        .dynamicTypeSize(.small ... .xLarge) // Enables dynamic text scaling
                } // Adjusts based on system settings
            }
        }
        .padding()
        .background(color?.opacity(0.1) ?? Color.gray.opacity(0.2))
        .cornerRadius(20)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
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
        teamColour: "3671C6",
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
    ), position: 3)
}
