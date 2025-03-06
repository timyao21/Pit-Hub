//
//  raceCalendarView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/20/25.
//

import SwiftUI

struct RaceCalendarView: View {
    @Bindable var viewModel: IndexViewModel
    
//    @State private var raceCalendarSelectedTab = 1
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
                YearDropdownSelector(selectedYear: $viewModel.raceCalendarViewYear) {
                    newYear in
                    viewModel.updateRaceCalendarViewYear(for: newYear)
                }
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                SeasonProgressView(viewModel: viewModel)
            }
            .padding(.horizontal)
            
            // MARK: - TabView
            TabView(selection: $viewModel.raceCalendarSelectedTab) {
                VStack{
                    raceCalendarScrollView(raceCalendar: viewModel.raceCalendarUpcoming)
                }
                .tag(0)
                
                VStack{
                    raceCalendarScrollView(raceCalendar: viewModel.raceCalendarPast.reversed())
                }
                .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .refreshable {
            await viewModel.refreshRaceCalendarData()
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
