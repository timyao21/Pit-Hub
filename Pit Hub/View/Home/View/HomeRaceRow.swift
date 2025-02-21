//
//  HomeRaceRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct HomeRaceRow: View {
    
    let upcomingGP: GP?
    
    var body: some View {
        VStack{
            if (upcomingGP != nil){
                HStack {
                    VStack (alignment: .leading){
//                        Text("\(upcomingGP!.circuit.circuitName)")
                        Text(NSLocalizedString("\(upcomingGP!.circuit.circuitName)", comment: "Circuit name for upcoming Grand Prix"))
                        Text(NSLocalizedString("\(upcomingGP!.raceName)", comment: "Race name for upcoming Grand Prix"))
                            .font(.custom(S.smileySans, size: 40))
                            .padding(.vertical, 2)
//                        Text("\(upcomingGP!.raceName)")
//                            .font(.custom(S.smileySans, size: 40))
                        if let localDate = DateUtilities.convertUTCToLocal(date: upcomingGP!.date, time: upcomingGP!.time!, format: "yyyy-MM-dd") {
                            Text("\(localDate)")
                        }
                    }
                    .font(.custom(S.smileySans, size: 20))
                    Spacer()
                    Image(upcomingGP!.circuit.circuitId)
                        .resizable()
                        .renderingMode(.template) // Makes the image render as a template
                        .scaledToFit()
                        .frame(width: 125)
                        .foregroundColor(Color("circuitColor")) // Applies the color to the image
                    
                }
            }
            VStack(spacing: 10) {
                if (upcomingGP!.firstPractice != nil){
                    RaceList(title: NSLocalizedString("FP1", comment: "First Practice"), date: "\(upcomingGP!.firstPractice!.date)", time: "\(upcomingGP!.firstPractice!.time!)")
                }
                if (upcomingGP!.secondPractice != nil){
                    RaceList(title: NSLocalizedString("FP2", comment: "Second Practice"), date: "\(upcomingGP!.secondPractice!.date)", time: "\(upcomingGP!.secondPractice!.time!)")
                }
                if (upcomingGP!.sprintQualifying != nil){
                    RaceList(title: NSLocalizedString("Sprint Quali", comment: "Sprint Quali"), date: "\(upcomingGP!.sprintQualifying!.date)", time: "\(upcomingGP!.sprintQualifying!.time!)")
                }
                if (upcomingGP!.thirdPractice != nil){
                    RaceList(title: NSLocalizedString("FP3", comment: "Third Practice"), date: "\(upcomingGP!.thirdPractice!.date)", time: "\(upcomingGP!.thirdPractice!.time!)")
                }
                if (upcomingGP!.sprint != nil){
                    RaceList(title: NSLocalizedString("Sprint", comment: "Sprint"), date: "\(upcomingGP!.sprint!.date)", time: "\(upcomingGP!.sprint!.time!)")
                }
                if (upcomingGP!.qualifying != nil){
                    RaceList(title: NSLocalizedString("Qualifying", comment: "Qualifying"), date: "\(upcomingGP!.qualifying!.date)", time: "\(upcomingGP!.qualifying!.time!)")
                }
                RaceList(title: NSLocalizedString("Race", comment: "First Practice"), date: "\(upcomingGP!.date)", time: "\(upcomingGP!.time!)")
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
                .font(.footnote)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            if let localDate = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: "yyyy-MM-dd") {
                Text("\(localDate)")
                    .font(.footnote)
                    .frame(width: 120, alignment: .center)
            }else {
                Text("UTC: \(date)")
                    .font(.footnote)
                    .frame(width: 120, alignment: .center)
            }
            
            Spacer()
            
            if let localTime = DateUtilities.convertUTCToLocal(date: self.date, time: self.time, format: "HH:mm") {
                Text("\(localTime)")
                    .font(.footnote)
                    .frame(width: 100, alignment: .center)
            }else {
                Text("UTC: \(time)")
                    .font(.footnote)
                    .frame(width: 100, alignment: .center)
            }
        }
        .padding(3)
        Divider()
            .padding(.horizontal)
    }
}
