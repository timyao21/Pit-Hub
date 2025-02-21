//
//  StandingsView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/12/25.
//

import SwiftUI

struct StandingsView: View {
    @State private var selectedTab = 0
    @Namespace private var animation
    @ObservedObject var viewModel: IndexViewModel
    
    private let tabTitles = ["Driver", "Constructor"]
    
    var body: some View {
        VStack{
            HStack{
                Image(S.pitIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Spacer()
                NavTabSelector(selectedTab: $selectedTab, tabTitles: tabTitles)
                Spacer()
                YearDropdownSelector(selectedYear: $viewModel.standingViewYear) {
                    newYear in
                    viewModel.updateStandingViewYear(for: newYear)
                }
            }
            .padding(.horizontal)
            
            TabView(selection: $selectedTab) {
                VStack {
                    ScrollView{
                        if (viewModel.driverStanding.isEmpty) {
                            ErrorView()
                        } else {
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
                    }
                    .refreshable {
                        await viewModel.refreshStandingData()
                    }
                }
                .tag(0)
                
                VStack{
                    ScrollView{
                        if (viewModel.constructorStanding.isEmpty){
                            ErrorView()
                        } else{
                            ForEach(viewModel.constructorStanding.indices, id: \.self){
                                index in
                                let constructorInfo = viewModel.constructorStanding[index]
                                let currentPoints = Int(constructorInfo.points) ?? 0
                                let previousPoints = index > 0 ? Int(viewModel.constructorStanding[index - 1].points) ?? 0 : currentPoints
                                let pointsDifference = previousPoints - currentPoints
                                
                                ConstructorStandingsRowView(position: "\(constructorInfo.position!)", constructor: constructorInfo.constructor, pointsDiff: "\(pointsDifference)", points: "\(constructorInfo.points)")
                                    .padding(.horizontal)
                                
                                if index < viewModel.constructorStanding.count - 1 {
                                    Divider()
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.refreshStandingData()
                    }
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
    }
}
