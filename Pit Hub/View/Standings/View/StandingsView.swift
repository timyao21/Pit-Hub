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
    @Bindable var viewModel: IndexViewModel
    
    private let tabTitles = ["Driver", "Constructor"]
    
    var body: some View {
        VStack{
            headerView
            
            TabView(selection: $selectedTab) {
                VStack {
                    driversStandingsScrollView(driverStanding: viewModel.driverStanding, for: viewModel.standingViewYear)
                        .refreshable {
                            await viewModel.refreshStandingData()
                        }
                }
                .tag(0)
                
                VStack{
                    constructorsStandingsScrollView(constructorsStanding: viewModel.constructorStanding)
                        .refreshable {
                            await viewModel.refreshStandingData()
                        }
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    private var headerView: some View {
        HStack {
            Image(S.pitIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            Spacer()
            NavTabSelector(selectedTab: $selectedTab, tabTitles: tabTitles)
            Spacer()
            YearDropdownSelector(selectedYear: $viewModel.standingViewYear) { newYear in
                Task {
                    await viewModel.updateStandingViewYear(for: newYear)
                }
            }
        }
        .padding(.horizontal)
    }
    
}

@ViewBuilder
private func driversStandingsScrollView(driverStanding: [DriverStanding] = [], for year: String) -> some View {

    ScrollView{
        if (driverStanding.isEmpty) {
            DataErrorView()
        } else {
            ForEach(Array(driverStanding.enumerated()), id: \.element.driver.driverId) { index, driverInfo in
                let currentPoints = Int(driverInfo.points) ?? 0
                let previousPoints = index > 0 ? Int(driverStanding[index - 1].points) ?? 0 : currentPoints
                let pointsDifference = previousPoints - currentPoints
                
                NavigationLink(destination: DriverDetailView(for: driverInfo, year: year)) {
                    DriversStandingsRowView(driverId: driverInfo.driver.driverId, position: "\(driverInfo.positionText ?? "")", driverFirstName: driverInfo.driver.givenName, driverLastName: driverInfo.driver.familyName, pointsDiff: "\(pointsDifference)", points: "\(driverInfo.points)", constructor: driverInfo.constructors.last ?? nil)
                }
                .foregroundColor(.primary)
                
                if index < driverStanding.count - 1 { // Avoids divider after the last row
                    Divider()
                        .padding(.horizontal)
                }
            }
        }
    }
}

@ViewBuilder
private func constructorsStandingsScrollView(constructorsStanding: [ConstructorStanding] = []) -> some View {
    ScrollView{
        if (constructorsStanding.isEmpty){
            DataErrorView()
        } else{
            ForEach(Array(constructorsStanding.enumerated()), id: \.element.constructor.constructorId) { index, constructorInfo in
                let currentPoints = Int(constructorInfo.points) ?? 0
                let previousPoints = index > 0 ? Int(constructorsStanding[index - 1].points) ?? 0 : currentPoints
                let pointsDifference = previousPoints - currentPoints
                
                ConstructorStandingsRowView(position: "\(constructorInfo.positionText)", constructor: constructorInfo.constructor, pointsDiff: "\(pointsDifference)", points: "\(constructorInfo.points)")
                
                if index < constructorsStanding.count - 1 {
                    Divider()
                        .padding(.horizontal)
                }
            }
        }
    }
}
