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
                        Text("\(upcomingGP!.circuit.circuitName)")
                        Text("\(upcomingGP!.raceName)")
                            .font(.custom(S.smileySans, size: 40))
                        Text("\(upcomingGP!.date)")
                    }
                    .font(.custom(S.smileySans, size: 20))
                    Spacer()
                    Image(upcomingGP!.circuit.circuitId)
                        .resizable()
                        .renderingMode(.template) // Makes the image render as a template
                        .scaledToFit()
                        .frame(width: 150)
                        .foregroundColor(Color("circuitColor")) // Applies the color to the image
                    
                }
            }
            List {
                if (upcomingGP!.firstPractice != nil){
                    RaceList(title: "FP1", date: "\(upcomingGP!.firstPractice!.date)", time: "\(upcomingGP!.firstPractice!.time!)")
                }
                if (upcomingGP!.secondPractice != nil){
                    RaceList(title: "FP2", date: "\(upcomingGP!.secondPractice!.date)", time: "\(upcomingGP!.secondPractice!.time!)")
                }
                if (upcomingGP!.thirdPractice != nil){
                    RaceList(title: "FP3", date: "\(upcomingGP!.thirdPractice!.date)", time: "\(upcomingGP!.thirdPractice!.time!)")
                }
                if (upcomingGP!.qualifying != nil){
                    RaceList(title: "Qualifying", date: "\(upcomingGP!.qualifying!.date)", time: "\(upcomingGP!.qualifying!.time!)")
                }
                RaceList(title: "Race", date: "\(upcomingGP!.date)", time: "\(upcomingGP!.time!)")
            }
            .listStyle(.plain)
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
            Spacer()
            Text("\(date)")
            Spacer()
            Text("\(time)")
        }
    }
}
