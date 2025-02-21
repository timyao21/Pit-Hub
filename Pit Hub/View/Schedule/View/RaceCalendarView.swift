//
//  raceCalendarView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/20/25.
//

import SwiftUI

struct RaceCalendarView: View {
    @ObservedObject var viewModel = IndexViewModel()
    
    @State private var selectedTab = 0
    @Namespace private var animation
    private let tabTitles = ["Past", "Upcoming"]
    
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
                YearDropdownSelector(selectedYear: $viewModel.raceCalendarViewYear) {
                    newYear in
                    viewModel.updateRaceCalendarViewYear(for: newYear)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                SeasonProgressView(totalGP: viewModel.raceCalendar.count, pastGP: viewModel.raceCalendarPast.count)
            }
            .padding(.horizontal)
            
            // MARK: - TabView
            TabView(selection: $selectedTab) {
                VStack{
                    ScrollView{
                        if (viewModel.raceCalendarUpcoming.isEmpty) {
                            ErrorView()
                        } else{
                            ForEach(viewModel.raceCalendarUpcoming.indices, id: \.self){
                                index in
                                let raceInfo = viewModel.raceCalendarUpcoming[index]
                                
                                RaceCalendarRowView(round: raceInfo.round, raceName: raceInfo.raceName, circuitId: raceInfo.circuit.circuitId, locality: raceInfo.circuit.location.locality, country: raceInfo.circuit.location.country, date: raceInfo.date, time: raceInfo.time ?? "", sprint: raceInfo.sprint != nil)
                                
                                if index < viewModel.raceCalendarUpcoming.count - 1 { // Avoids divider after the last row
                                    Divider()
                                        .padding(.horizontal)
                                }
                                
                            }
                        }
                    }
                }
                .tag(0)
            }
            

            
            
        }
        //End of vstack
    }
}

#Preview {
    BottomNavBarIndexView()
}
