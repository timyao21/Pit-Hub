//
//  ScheduleDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/12/25.
//

import SwiftUI

struct ScheduleDetailView: View {
    
    var meeting: Meeting
    
    @StateObject var viewModel = ViewModel()
    @State var displaySessions:  [Session] = []
    @State private var selectedTab = 1
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(meeting.meetingName)
                    .font(.custom(S.smileySans, size: 20))
                Text(CountryNameTranslator.translate(englishName: meeting.circuitShortName))
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
            
            TabSelecter(selectedTab: $selectedTab, animation: animation)
            
            TabView(selection: $selectedTab) {
                // 正赛成绩标签页
                VStack(spacing: 20) {
                    Text("正赛成绩")
                        .font(.custom(S.smileySans, size: 17))
                    
                    VStack(alignment: .leading) {
                        Text("• 第一名：张三 - 1:30.456")
                        Text("• 第二名：李四 - 1:31.789")
                        Text("• 第三名：王五 - 1:32.012")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("正赛")
                }
                .tag(1)
                
                // 排位赛成绩标签页
                VStack(spacing: 20) {
                    Text("排位赛成绩")
                        .font(.custom(S.smileySans, size: 17))
                    
                    VStack(alignment: .leading) {
                        Text("• 第一名：赵六 - 1:28.456")
                        Text("• 第二名：孙七 - 1:29.789")
                        Text("• 第三名：周八 - 1:30.012")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .tabItem {
                    Image(systemName: "timer")
                    Text("排位赛")
                }
                .tag(2)
            }
            .tabViewStyle(.page)
        }
        .withCustomNavigation()
        .padding()
        .onAppear {
            viewModel.fetchSessions(meeting.meetingKey, for: meeting.dateStart)
        }
    }
}

#Preview {
    ScheduleDetailView(meeting:Meeting(
        circuitKey: 63,
        circuitShortName: "Jeddah",
        countryCode: "SGP",
        countryKey: 157,
        countryName: "Bahrain",
        dateStart: "2023-09-19T09:30:00+00:00",
        gmtOffset: "08:00:00",
        location: "Marina Bay",
        meetingKey: 1219,
        meetingName: "Bahrain Grand Prix",
        meetingOfficialName: "FORMULA 1 SINGAPORE AIRLINES SINGAPORE GRAND PRIX 2023",
        year: 2024
    ))
}

// MARK: - Custom Tab Selector
struct TabSelecter: View {
    @Binding var selectedTab: Int
    var animation: Namespace.ID

    var body: some View {
        HStack(spacing: 10) {
            tabButton(title: "正赛成绩", tab: 1)
            tabButton(title: "排位赛成绩", tab: 2)
            tabButton(title: "赛道介绍", tab: 3)
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
