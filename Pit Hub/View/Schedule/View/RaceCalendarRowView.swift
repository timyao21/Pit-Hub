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
                .frame(width: 33, alignment: .leading)
                .foregroundColor(.primary)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 2){
                    Text(CountryFlags.flag(for: country))
                    Text(locality)
                        .font(.headline)
                        .foregroundColor(.primary)
                    if sprint {
                        SprintBadge()
                    }
                }
                
                Text(raceName)
                    .font(.title2)
                    .foregroundColor(.primary)

                Text("\(date)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            Image(circuitId)
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .foregroundColor(Color("circuitColor")) // Applies the color to the image
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

struct RaceCalendarRowView_Previews: PreviewProvider {
    static var previews: some View {
        RaceCalendarRowView(round: "10", raceName: "Bahrain GP", circuitId: "americas",locality:"Austin", country:"USA", date: "March 2, 2024", time: "15:00 GMT", sprint: true)
    }
}
