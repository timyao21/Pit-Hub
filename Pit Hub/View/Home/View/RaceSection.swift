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
                            Text(LocalizedStringKey(race?.circuit.circuitName ?? ""))
                                .font(.custom(S.smileySans, size: 18))
                            if ((race?.sprint) != nil){
                                SprintBadge()
                            }
                        }
                        Text(LocalizedStringKey(race!.raceName))
                            .font(.title)
                            .fontWeight(.bold)
                        if let localDate = DateUtilities.convertUTCToLocal(date: race!.date, time: race!.time!, format: DateUtilities.localizedDateFormat(for: "yyyy-MM-dd")) {
                            Text("\(localDate)")
                                .font(.headline)
                        }
                    }

                    Spacer()
                    Image(race!.circuit.circuitId)
                        .resizable()
                        .renderingMode(.template) // Makes the image render as a template
                        .scaledToFit()
                        .frame(width: 125)
                        .foregroundColor(Color("circuitColor")) // Applies the color to the image
                    
                }
            }
            Text("All times are in your local time zone")
                .font(.footnote)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 10) {
                if (race!.firstPractice != nil){
                    RaceSessionList(title: "FP1", date: "\(race!.firstPractice!.date)", time: "\(race!.firstPractice!.time!)")
                }
                if (race!.secondPractice != nil){
                    RaceSessionList(title: "FP2", date: "\(race!.secondPractice!.date)", time: "\(race!.secondPractice!.time!)")
                }
                if (race!.sprintQualifying != nil){
                    RaceSessionList(title: "Sprint Quali", date: "\(race!.sprintQualifying!.date)", time: "\(race!.sprintQualifying!.time!)")
                }
                if (race!.thirdPractice != nil){
                    RaceSessionList(title: "FP3", date: "\(race!.thirdPractice!.date)", time: "\(race!.thirdPractice!.time!)")
                }
                if (race!.sprint != nil){
                    RaceSessionList(title: "Sprint", date: "\(race!.sprint!.date)", time: "\(race!.sprint!.time!)")
                }
                if (race!.qualifying != nil){
                    RaceSessionList(title: "Qualifying", date: "\(race!.qualifying!.date)", time: "\(race!.qualifying!.time!)")
                }
                RaceSessionList(title: "Race", date: "\(race!.date)", time: "\(race!.time!)")
            }
        }
    }
}

struct RaceSessionList: View {
    let title: LocalizedStringKey
    let date: String
    let time: String
    
    var body: some View {
        HStack{
            Text(title)
                .font(.body)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            if let localDate = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: DateUtilities.localizedDateFormat(for: "MM-dd")) {
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
