//
//  StandingsView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/12/25.
//

import SwiftUI

struct StandingsView: View {
    @State private var selectedTab = 0
    @ObservedObject var viewModel: IndexViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack {
                Text("\(viewModel.standingViewYear) Driver Standings")
                    .foregroundColor(Color(S.pitHubIconColor))
                    .font(.custom(S.smileySans, size: 23))
                    .bold()
                ScrollView{
                    ForEach(viewModel.driverStanding.indices, id: \.self){
                        index in
                        let driverInfo = viewModel.driverStanding[index]
                        let currentPoints = Int(driverInfo.points) ?? 0
                        let previousPoints = index > 0 ? Int(viewModel.driverStanding[index - 1].points) ?? 0 : currentPoints
                        let pointsDifference = previousPoints - currentPoints
                        
                        
                        DriversStandingsRowView(position: "\(driverInfo.position!)", driverFirstName: driverInfo.driver.givenName, driverLastName: driverInfo.driver.familyName, pointsDiff: "\(pointsDifference)", points: "\(driverInfo.points)", constructor: driverInfo.constructors.first ?? nil)
                        
                        if index < viewModel.driverStanding.count - 1 { // Avoids divider after the last row
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .refreshable {
                    await viewModel.refreshData()
                }
            }
            .tag(0)
            
            VStack{
                Text("\(viewModel.standingViewYear) Constructor Standings")
                    .foregroundColor(Color(S.pitHubIconColor))
                    .font(.custom(S.smileySans, size: 23))
                    .bold()
                ScrollView{
                    ForEach(viewModel.constructorStanding.indices, id: \.self){
                        index in
                        let constructorInfo = viewModel.constructorStanding[index]
                        let currentPoints = Int(constructorInfo.points) ?? 0
                        let previousPoints = index > 0 ? Int(viewModel.constructorStanding[index - 1].points) ?? 0 : currentPoints
                        let pointsDifference = previousPoints - currentPoints
                        
                        ConstructorStandingsRowView(position: "\(constructorInfo.position!)", constructor: constructorInfo.constructor, pointsDiff: "\(pointsDifference)", points: "\(constructorInfo.points)")
                        
                        if index < viewModel.constructorStanding.count - 1 {
                            Divider()
                                .padding(.horizontal)
                        }
                    }
                }
                .refreshable {
                    await viewModel.refreshData()
                }
            }
            .tag(1)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }
}
