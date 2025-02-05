//
//  StandingsRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/19/25.
//

import SwiftUI

struct StandingsRowView: View {
    let driver: Driver
    let position: Int
    
    var body: some View {
        HStack {
            // Position Number (Standing)
            Text("\(position)")
                .font(.custom(S.smileySans, size: 25))
                .fontWeight(.bold)
                .foregroundColor(positionColor(for: position)) // Dynamic color based on position
                .frame(width: 35, alignment: .center) // Centered for consistency

            
            // Driver Number with Circle Background
            Text("\(driver.driverNumber)")
                .font(.custom(S.smileySans, size: 28)) // Slightly smaller for better balance
                .foregroundStyle(gradientBackground(from: driver.teamColour))
                .frame(width: 40, height: 40, alignment: .center) // Balanced width & height
                .background(
                    Circle()
                        .fill(color(from: driver.teamColour).opacity(0.3)) // Slightly darker for contrast
                        .frame(width: 40, height: 40)
                )

            VStack(alignment: .leading) {
                Text(NSLocalizedString(driver.lastName, comment: "Driver last name"))
                    .font(.custom(S.smileySans, size: 25))
                Text(NSLocalizedString(driver.teamName, comment: "Driver team name"))
                    .font(.custom(S.smileySans, size: 18))
                    .foregroundStyle(gradientBackground(from: driver.teamColour))
            }
            Spacer()
            Text("\(driver.points) 积分")
                .font(.custom(S.smileySans, size: 23))
            Image(systemName: "chevron.right")
        }
        .padding(5)
    }
}

#Preview {
    StandingsRowView(driver: Driver(
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
    ),position: 1)
}

extension StandingsRowView{
    func gradientBackground(from hex: String) -> LinearGradient {
        let color = color(from: hex)
        return LinearGradient(
            gradient: Gradient(colors: [color, color.opacity(0.7)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    func color(from hex: String) -> Color {
         let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
         var int: UInt64 = 0
         Scanner(string: hex).scanHexInt64(&int)
         let r, g, b: Double
         switch hex.count {
         case 6: // RGB (24-bit)
             (r, g, b) = (
                 Double((int >> 16) & 0xFF) / 255,
                 Double((int >> 8) & 0xFF) / 255,
                 Double(int & 0xFF) / 255
             )
         default:
             return .gray // Fallback to gray for invalid hex
         }
         return Color(.sRGB, red: r, green: g, blue: b, opacity: 1.0)
     }
    
    func positionColor(for position: Int) -> Color {
        switch position {
        case 1:
            return .yellow // 🥇 Gold for 1st place
        case 2:
            return Color.blue.opacity(0.8) //  A distinct blue shade for 2nd place
        case 3:
            return Color.orange // 🟠 Bronze for 3rd place
        case 4...:
            return Color.gray.opacity(0.8) // ⚪ Light gray for positions 11 and beyond
        default:
            return .gray // Default fallback color
        }
    }


}
