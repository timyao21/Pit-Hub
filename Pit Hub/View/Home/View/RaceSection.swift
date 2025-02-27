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
        VStack{
            if (race != nil){
                HStack {
                    VStack (alignment: .leading, spacing: 3) {
                        HStack{
                            Text(NSLocalizedString("\(race!.circuit.circuitName)", comment: "Circuit name for upcoming Grand Prix"))
                            if ((race?.sprint) != nil){
                                SprintBadge()
                            }
                        }
                        Text(NSLocalizedString("\(race!.raceName)", comment: "Race name for upcoming Grand Prix"))
                            .font(.custom(S.orbitron, size: 30))
                            .fontWeight(.bold)
                        if let localDate = DateUtilities.convertUTCToLocal(date: race!.date, time: race!.time!, format: "yyyy-MM-dd") {
                            Text("\(localDate)")
                        }
                    }
                    .font(.custom(S.smileySans, size: 20))
                    Spacer()
                    Image(race!.circuit.circuitId)
                        .resizable()
                        .renderingMode(.template) // Makes the image render as a template
                        .scaledToFit()
                        .frame(width: 125)
                        .foregroundColor(Color("circuitColor")) // Applies the color to the image
                    
                }
            }
            VStack(spacing: 10) {
                if (race!.firstPractice != nil){
                    RaceList(title: NSLocalizedString("FP1", comment: "First Practice"), date: "\(race!.firstPractice!.date)", time: "\(race!.firstPractice!.time!)")
                }
                if (race!.secondPractice != nil){
                    RaceList(title: NSLocalizedString("FP2", comment: "Second Practice"), date: "\(race!.secondPractice!.date)", time: "\(race!.secondPractice!.time!)")
                }
                if (race!.sprintQualifying != nil){
                    RaceList(title: NSLocalizedString("Sprint Quali", comment: "Sprint Quali"), date: "\(race!.sprintQualifying!.date)", time: "\(race!.sprintQualifying!.time!)")
                }
                if (race!.thirdPractice != nil){
                    RaceList(title: NSLocalizedString("FP3", comment: "Third Practice"), date: "\(race!.thirdPractice!.date)", time: "\(race!.thirdPractice!.time!)")
                }
                if (race!.sprint != nil){
                    RaceList(title: NSLocalizedString("Sprint", comment: "Sprint"), date: "\(race!.sprint!.date)", time: "\(race!.sprint!.time!)")
                }
                if (race!.qualifying != nil){
                    RaceList(title: NSLocalizedString("Qualifying", comment: "Qualifying"), date: "\(race!.qualifying!.date)", time: "\(race!.qualifying!.time!)")
                }
                RaceList(title: NSLocalizedString("Race", comment: "First Practice"), date: "\(race!.date)", time: "\(race!.time!)")
                Text(NSLocalizedString("All times are in your local time zone", comment: "All times are in your local time zone"))
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct RaceList: View {
    let title: String
    let date: String
    let time: String
    
    var body: some View {
        HStack{
            Text("\(title)")
                .font(.body)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            if let localDate = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: "MM-dd") {
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
