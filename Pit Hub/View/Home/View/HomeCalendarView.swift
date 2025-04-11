//
//  HomeCalendarView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/27/25.
//

import SwiftUI

struct HomeCalendarView: View {
    @State var viewModel: HomeCalendarViewModel
    let daysOfWeek = Date.capitalizedFirstLetterOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(for races: [Races]) {
        viewModel = HomeCalendarViewModel(for: races)
    }
    
    init(for race: Races) {
        self.init(for: [race])
    }
    
    var body: some View {
        VStack{
            headerView
            calendarGrid
        }
    }
    
    // Header view with days of the week.
    private var headerView: some View {
        HStack {
            ForEach(daysOfWeek.indices, id: \.self) { index in
                Text(daysOfWeek[index])
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // Calendar grid view.
    private var calendarGrid: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.days.indices, id: \.self) { index in
                        Group {
                            if let day = viewModel.days[index] {
                                // Find a race that occurs on this day.
                                let matchingRace = viewModel.raceCalendarDate.first { race in
                                    Calendar.current.isDate(race.date, inSameDayAs: day)
                                }

                                DayCell(
                                    day: day,
                                    circuitId: matchingRace?.raceName ?? "-",
                                    hasRace: matchingRace != nil,
                                    session: matchingRace?.session ?? "-"
                                )
                            } else {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(maxWidth: .infinity, minHeight: 60)
                            }
                        }
                        .id(index)
                    }
                }
                .onAppear {
                    // Scroll to the week that contains today.
                    if let currentIndex = viewModel.days.firstIndex(where: { day in
                        guard let day = day else { return false }
                        return Calendar.current.isDate(day, inSameDayAs: Date())
                    }) {
                        let weekStartIndex = (currentIndex / 7) * 7
                        DispatchQueue.main.async {
                            withAnimation {
                                proxy.scrollTo(weekStartIndex, anchor: .top)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .scrollDisabled(true)
        }
    }
    
    
    // A reusable day cell view.
    private struct DayCell: View {
        let day: Date
        let circuitId: String
        let hasRace: Bool
        let session: String
        private let calendar = Calendar.current
        
        var body: some View {
            let isToday = calendar.isDate(day, inSameDayAs: Date())
            let dayComponent = calendar.component(.day, from: day)
            let monthComponent = calendar.component(.month, from: day)
            
            return VStack(spacing: 2) {
                if dayComponent == 1 {
                    Text(calendar.shortMonthSymbols[monthComponent - 1])
                        .foregroundColor(.primary)
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(height: 10)
                } else if session == "FP"{
                    Text(LocalizedStringKey(circuitId))
                        .foregroundColor(Color(S.pitHubIconColor))
                        .font(.caption)
                        .fontWeight(.bold)
                        .frame(height: 10)
                }else {
                    Text("")
                        .font(.caption)
                        .frame(height: 10)
                }
                Text("\(dayComponent)")
                    .fontWeight(.bold)
                    .padding(5)
                    .background {
                        Circle()
                            .fill(isToday ? Color.blue : Color.clear)
                    }
                    .foregroundColor(
                        isToday
                            ? Color.white
                            : (hasRace ? Color(S.pitHubIconColor) : Color.primary)
                    )
                Text(LocalizedStringKey(session))
                    .font(.caption)
                    .foregroundColor(hasRace ? Color(S.pitHubIconColor) : Color.secondary)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
        }
    }
    
}

#Preview {
    HomeCalendarView(for: [Races.sample])
}
