//
//  RaceCalendarRowView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/20/25.
//

import SwiftUI

struct RaceCalendarRowView: View {
    let round: String
    let raceName: String
    let circuitId: String
    let locality: String
    let country: String
    let date: String
    let time: String
    let sprint: Bool
    
    var body: some View {
        HStack() {
            Text(round)
                .font(.title)
                .frame(width: 40, alignment: .leading)
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 3){
                    Text(CountryFlags.flag(for: country))
                    Text(LocalizedStringKey(locality))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    if sprint {
                        SprintBadge()
                    }
                }
                
                Text(LocalizedStringKey(raceName))
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading )
                if let localDate = DateUtilities.convertUTCToLocal(date: date, time: time, format: "yyyy-MM-dd") {
                    Text("\(localDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth:.infinity, alignment: .leading)
            
            Image(circuitId)
                .resizable()
                .renderingMode(.template) // Makes the image render as a template
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(.primary) // Applies the color to the image
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct RaceCalendarRowView_Previews: PreviewProvider {
    static var previews: some View {
        RaceCalendarRowView(round: "10", raceName: "Saudi Arabian Grand Prix123", circuitId: "americas",locality:"Austin", country:"USA", date: "March 2, 2024", time: "15:00 GMT", sprint: true)
    }
}
