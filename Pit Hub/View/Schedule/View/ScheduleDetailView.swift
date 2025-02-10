//
//  ScheduleDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/12/25.
//

import SwiftUI

struct ScheduleDetailView: View {
    
    var grandPrix: GrandPrix
    
    @StateObject var viewModel = ViewModel()
    @State var displaySessions:  [Session] = []
    @State private var selectedTab = 1
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                HStack {
                    Text(grandPrix.meetingName)
                        .font(.custom(S.smileySans, size: 20))
                    SprintBadge()
                        .opacity(grandPrix.sprint ? 1 : 0) // Hides the view when `gp.sprint` is false
                }
                Text(CountryNameTranslator.translate(englishName: grandPrix.circuitShortName))
                    .font(.custom(S.smileySans, size: 35))
                    .padding(.top, 2)
                    .padding(.bottom, 2)
                Text("\(viewModel.startDate) - \(viewModel.endDate)")
                    .font(.custom(S.smileySans, size: 25))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            List(viewModel.sessions) { session in
                ScheduleSessionRowView(session: session)
            }
            .listStyle(.plain)
            
            HStack {
                Spacer()
                TabSelecter(selectedTab: $selectedTab, animation: animation)
                Spacer()
            }
            .padding(.vertical, 10)
            
            TabView(selection: $selectedTab) {
                VStack(spacing: 20) {
                    TabSubview(results: viewModel.raceResults) // Call the subview
                }
                .tabItem {
                    Text("正赛")
                }
                .tag(1)
                
                // 排位赛成绩标签页
                VStack(spacing: 20) {
                    Text("⏳ 技师们正全力维修...")
                        .font(.custom(S.smileySans, size: 17))
                }
                .tabItem {
                    Text("排位赛")
                }
                .tag(2)
            }
            .tabViewStyle(.page)
        }
        .withCustomNavigation()
        .padding()
        .onAppear {
            viewModel.fetchSessions(grandPrix.meetingKey, for: grandPrix.dateStart)
            Task {
                await viewModel.fetchRaceResults(for: grandPrix.meetingKey)
            }
        }
    }
}

#Preview {
    ScheduleListView()
}


// MARK: - Custom Tab Selector
struct TabSelecter: View {
    @Binding var selectedTab: Int
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 10) {
            tabButton(title: "正赛成绩", tab: 1)
            tabButton(title: "排位赛成绩", tab: 2)
        }
        .padding(8)
        .background(Color.gray.opacity(0.2)) // Light background for contrast
        .clipShape(Capsule()) // Smooth rounded edges
    }

    private func tabButton(title: String, tab: Int) -> some View {
        Button(action: { selectedTab = tab }) {
            Text(title)
                .font(.custom(S.smileySans, size: 15))
                .foregroundColor(selectedTab == tab ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .background(selectedTab == tab ? Color(S.pitHubIconColor) : Color.clear)
                .clipShape(Capsule()) // Rounded button style
                .animation(.easeInOut(duration: 0.35), value: selectedTab)
        }
        .buttonStyle(PlainButtonStyle()) // Removes default button tap effect
    }
}

struct TabSubview: View {
    let results: [RaceResult] // Uses the `RaceResult` model

    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ForEach(results) { result in
                    HStack {
                        Text(result.dns ? "DNS" : result.dnf ? "DNF" : result.dq ? "DQ" : "\(result.position)")
                            .font(.headline)
                            .frame(width: 40)


                        Text(NSLocalizedString(result.lastName, comment: "Driver last name"))
                            .font(.custom(S.smileySans, size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        Text("\(result.points)分")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

