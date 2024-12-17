//
//  ScheduleList.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleList: View {
    
    @State private var viewModel = ViewModel()
    
    private let scheduleManager: ScheduleManager
    
//    @State private var upcomingMeetings = [Meeting]()
    
    @State private var upcomingMeetings = [Meeting]([
        Meeting(
            circuitKey: 63,
            circuitShortName: "Sakhir",
            countryCode: "SGP",
            countryKey: 157,
            countryName: "Bahrain",
            dateStart: "2023-09-19T09:30:00+00:00",
            gmtOffset: "08:00:00",
            location: "Marina Bay",
            meetingKey: 1219,
            meetingName: "Bahrain Grand Prix",
            meetingOfficialName: "FORMULA 1 SINGAPORE AIRLINES SINGAPORE GRAND PRIX 2023",
            year: 2023
        )
    ])
    
    var body: some View {
        NavigationSplitView{
            VStack{
                if upcomingMeetings.isEmpty && viewModel.pastMeetings.isEmpty {
                    Text("暂无日程")
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            if !upcomingMeetings.isEmpty {
                                SectionHeader(title: "接下来...")
                                ForEach(upcomingMeetings) { meeting in
                                    NavigationLink {
                                        ScheduleDetail(sessionManager: SessionManager(circuitShortName: meeting.circuitShortName, year: meeting.year), meeting: meeting)
                                    } label: {
                                        ScheduleRow(meeting: meeting)
                                    }
                                    .padding(.horizontal, 16)
                                    .background(Color(S.primaryBackground))
                                    .cornerRadius(8)
                                    .padding(.vertical, 4)
                                    .tint(.primary) // Prevent the blue tint
                                }
                            }
                            if !viewModel.pastMeetings.isEmpty {
                                SectionHeader(title: "已结束...")
                                ForEach(viewModel.pastMeetings) { meeting in
                                    NavigationLink {
                                        ScheduleDetail(sessionManager: SessionManager(circuitShortName: meeting.circuitShortName, year: meeting.year), meeting: meeting)
                                    } label: {
                                        ScheduleRow(meeting: meeting)
                                            .padding(.vertical, 2)
                                    }
                                    .padding(.horizontal, 16)
                                    .background(Color(S.primaryBackground))
                                    .tint(.primary) // Prevent the blue tint
                                    .cornerRadius(18)
                                    .padding(.vertical, 6)
                                }
                            }
                        }
                    }
                    .background(Color(S.primaryBackground))
                }
            }
        } detail: {
            Text("Select a Schedule")
        }
        .onAppear {
            fetchMeetings()
        }
    }
    // MARK: - set up scheduleManager
    init(scheduleManager: ScheduleManager) {
        self.scheduleManager = scheduleManager
    }
    
    // MARK: - fecth Meetings
    func fetchMeetings() {
//        scheduleManager.getUpcomingMeetings { meetings in
//            DispatchQueue.main.async {
//                self.upcomingMeetings = meetings ?? []
//            }
//        }
        
        scheduleManager.getPastMeetings { meetings in
            DispatchQueue.main.async {
                self.viewModel.pastMeetings = meetings ?? []
            }
        }
    }
    
}

    // MARK: - Section Header Text Style
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.custom(S.smileySans, size: 30))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            .padding(.vertical, 8)
    }
}

#Preview {
    ScheduleList(scheduleManager: ScheduleManager(year: 2023))
}
