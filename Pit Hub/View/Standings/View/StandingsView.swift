//
//  StandingsView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/12/25.
//

import SwiftUI

struct StandingsView: View {
    @State private var selectedTab = 0
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                VStack {
                    Text("\(viewModel.year) Driver Standings")
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
//                            let constructorId = driverInfo.constructors.first ?? nil

                            
                            DriversStandingsRowView(position: "\(driverInfo.position!)", driverFirstName: driverInfo.driver.givenName, driverLastName: driverInfo.driver.familyName, pointsDiff: "\(pointsDifference)", points: "\(driverInfo.points)", constructor: driverInfo.constructors.first ?? nil)
                            
                            if index < viewModel.driverStanding.count - 1 { // Avoids divider after the last row
                                Divider()
                            }
                        }
                    }
                }
                .tag(0)
                ScrollView{
                    VStack{
                        Text("\(viewModel.year) Constructor Standings")
                            .foregroundColor(Color(S.pitHubIconColor))
                            .font(.custom(S.smileySans, size: 23))
                            .bold()
                    }
                }
                .tag(1)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .onAppear(){
            viewModel.fetchDriverStanding()
        }
    }
}

#Preview {
    StandingsView()
}
