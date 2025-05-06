//
//  raceCalendarView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/20/25.
//

import SwiftUI

struct RaceCalendarView: View {
    @Bindable var viewModel: HomepageViewModel
    @Namespace private var animation
    private let tabTitles = ["Upcoming", "Past"]
    
    var body: some View {
        VStack{
            HStack{
                Image(S.pitIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Spacer()
                NavTabSelector(selectedTab: $viewModel.raceCalendarSelectedTab, tabTitles: tabTitles)
                Spacer()
                YearDropdownSelector(selectedYear: $viewModel.raceCalendarViewSelectedYear) {
                    newYear in
                    viewModel.updateRaceCalendarViewYear(for: newYear)
                }
            }
            .padding(.horizontal)
            
            // MARK: - TabView
            TabView(selection: $viewModel.raceCalendarSelectedTab) {
                VStack{
                    raceCalendarScrollView(raceCalendar: viewModel.raceCalendarUpcomingRaces)
                }
                .tag(0)
                
                VStack{
                    raceCalendarScrollView(raceCalendar: viewModel.raceCalendarPastRaces.reversed())
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .refreshable {
            await viewModel.refreshRaceCalendarView()
        }
    }
}

#Preview {
    BottomNavBarIndexView()
}

@ViewBuilder
private func raceCalendarScrollView(raceCalendar: [Races] = []) -> some View {
    ScrollView {
        if raceCalendar.isEmpty {
            DataErrorView()
        } else {
            LazyVStack { // Use LazyVStack to optimize rendering
                ForEach(Array(raceCalendar.enumerated()), id: \.element.id) { index, raceInfo in
                    NavigationLink(destination: RaceCalendarDetailView(for: raceInfo)) {
                        RaceCalendarRowView(
                            round: raceInfo.round,
                            raceName: raceInfo.raceName,
                            circuitId: raceInfo.circuit.circuitId,
                            locality: raceInfo.circuit.location.locality,
                            country: raceInfo.circuit.location.country,
                            date: raceInfo.date,
                            time: raceInfo.time ?? "",
                            sprint: raceInfo.sprint != nil
                        )
                    }
                    
                    // Place a divider unless it's the last item
                    if index < raceCalendar.count - 1 {
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}
