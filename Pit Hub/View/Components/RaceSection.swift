//
//  HomeRaceRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct RaceSection: View {
    let race: Races?
    
    init(for race: Races?) {
        self.race = race
    }
    
    var body: some View {
        @Environment(\.locale) var locale
        Group {
            if let race = race {
                VStack (spacing: 6){
                    
                    // Race title and date with circuit image
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Text(CountryFlags.flag(for: race.circuit.location.country))
                                Text(LocalizedStringKey(race.circuit.circuitName))
                                    .font(.custom(S.smileySans, size: 18))
                            }
                            
                            Text(LocalizedStringKey(race.raceName))
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack{
                                if let localDate = DateUtilities.convertUTCToLocal(
                                    date: race.date,
                                    time: race.time!,
                                    format: DateUtilities.localizedDateFormat(for: "yyyy-MM-dd", language: locale.language.languageCode?.identifier ?? "en")
                                ) {
                                    Text("\(localDate)")
                                        .font(.headline)
                                }
                                
                                if race.sprint != nil {
                                    SprintBadge()
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(race.circuit.circuitId)
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFit()
                            .frame(width: 125)
                            .foregroundColor(Color("circuitColor"))
                    }
                    
                    // Local time zone notice
                    Text("All times are in your local time zone")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Session list
                    VStack(spacing: 10) {
                        // Optionally you could iterate over an array of sessions, but here we use if-lets.
                        if let fp1 = race.firstPractice {
                            RaceSessionList(title: "FP1", date: "\(fp1.date)", time: "\(fp1.time!)")
                        }
                        if let fp2 = race.secondPractice {
                            RaceSessionList(title: "FP2", date: "\(fp2.date)", time: "\(fp2.time!)")
                        }
                        if let sprintQuali = race.sprintQualifying {
                            RaceSessionList(title: "Sprint Quali", date: "\(sprintQuali.date)", time: "\(sprintQuali.time!)")
                        }
                        if let fp3 = race.thirdPractice {
                            RaceSessionList(title: "FP3", date: "\(fp3.date)", time: "\(fp3.time!)")
                        }
                        if let sprint = race.sprint {
                            RaceSessionList(title: "Sprint", date: "\(sprint.date)", time: "\(sprint.time!)")
                        }
                        if let qualifying = race.qualifying {
                            RaceSessionList(title: "Qualifying", date: "\(qualifying.date)", time: "\(qualifying.time!)")
                        }
                        // "Race" session is always shown
                        RaceSessionList(title: "Race", date: "\(race.date)", time: "\(race.time!)")
                    }
                }
            } else {
                // Provide a fallback view when race is nil
                Text("No race information available.")
            }
        }
    }
}

struct RaceSessionList: View {
    @Environment(\.locale) var locale
    let title: LocalizedStringKey
    let date: String
    let time: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.body)
                .frame(width: 100, alignment: .leading)
            
            Spacer()
            
            if let localDate = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: DateUtilities.localizedDateFormat(for: "MM-dd", language: locale.language.languageCode?.identifier ?? "en")) {
                Text("\(localDate)")
                    .font(.body)
                    .frame(width: 120, alignment: .center)
            }else {
                Text("UTC: \(date)")
                    .font(.footnote)
                    .frame(width: 120, alignment: .center)
            }
            
            Spacer()
            
            if let localTime = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: "HH:mm") {
                Text("\(localTime)")
                    .font(.body)
                    .frame(width: 100, alignment: .center)
            }else {
                Text("UTC: \(time)")
                    .font(.body)
                    .frame(width: 100, alignment: .center)
            }
        }
        .padding(3)
        Divider()
            .padding(.horizontal)
    }
}
