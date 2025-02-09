//
//  StandingsTeamRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/9/25.
//

import SwiftUI

struct StandingsTeamRowView: View {
    let team: F1Team
    let position: Int
    
    var body: some View {
        HStack{
            // Position Number (Standing)
            Text("\(position)")
                .font(.custom(S.smileySans, size: 28))
                .fontWeight(.bold)
                .foregroundColor(positionColor(for: position)) // Dynamic color based on position
                .frame(width: 35, alignment: .center) // Centered for consistency
            
            VStack(alignment: .leading) {
                Text(NSLocalizedString(team.shortName, comment: "Team Short Name"))
                    .font(.custom(S.smileySans, size: 25))
                Text(NSLocalizedString(team.carModel, comment: "Team Car Model Name"))
                    .font(.custom(S.smileySans, size: 18))
                    .foregroundStyle(gradientBackground(from: team.teamColour))
            }
            Spacer()
            Text("\(team.points) 分")
                .font(.custom(S.smileySans, size: 23))
        }
        .padding(5)
    }
}

#Preview {
    StandingsTeamRowView(team: F1Team(
        id: "redbull",
        teamName: "Oracle Red Bull Racing",
        shortName: "Red Bull",
        base: "Milton Keynes, UK",
        teamPrincipal: "Christian Horner",
        carModel: "RB20",
        engineSupplier: "Honda RBPT",
        teamColour: "1E5BC6",
        year: 2024,
        points: 450,
        drivers: ["Max Verstappen", "Sergio Perez"]), position: 1)
}

extension StandingsTeamRowView{
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
