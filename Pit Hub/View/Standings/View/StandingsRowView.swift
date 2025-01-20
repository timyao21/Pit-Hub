//
//  StandingsRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/19/25.
//

import SwiftUI

struct StandingsRowView: View {
    let driver: Driver
    var body: some View {
        HStack {
            Text("\(driver.driverNumber)")
                .frame(width: 30)
                .font(.custom(S.smileySans, size: 30))
                .foregroundStyle(gradientBackground(from: driver.teamColour))

            VStack(alignment: .leading) {
                Text(NSLocalizedString(driver.lastName, comment: "Driver last name"))
                    .font(.custom(S.smileySans, size: 25))
                Text(NSLocalizedString(driver.teamName, comment: "Driver team name"))
                    .font(.custom(S.smileySans, size: 18))
            }
            .foregroundStyle(gradientBackground(from: driver.teamColour))
            Spacer()
            Text("\(driver.points) 积分")
                .font(.custom(S.smileySans, size: 23))
            Image(systemName: "chevron.right")
        }
        .padding(5)
//        .cornerRadius(10)
//        .shadow(radius: 5)
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
    ))
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
}
