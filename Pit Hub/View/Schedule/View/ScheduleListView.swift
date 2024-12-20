//
//  ScheduleList.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleListView: View {
    
    @StateObject var viewModel = ViewModel()
    
    // MARK: - UI
    var body: some View {
        NavigationSplitView{
            VStack{
                if viewModel.upcomingMeetings.isEmpty && viewModel.pastMeetings.isEmpty {
                    Text("暂无日程")
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 0) {
                            if !viewModel.upcomingMeetings.isEmpty {
                                SectionHeader(title: "接下来...")
                                ForEach(viewModel.upcomingMeetings) { meeting in
                                    NavigationLink {
                                        ScheduleDetail(sessionManager: SessionManagerOld(circuitShortName: meeting.circuitShortName, year: meeting.year), meeting: meeting)
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
                                        ScheduleDetail(sessionManager: SessionManagerOld(circuitShortName: meeting.circuitShortName, year: meeting.year), meeting: meeting)
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
            viewModel.fetchMeetings()
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
    ScheduleListView()
}
