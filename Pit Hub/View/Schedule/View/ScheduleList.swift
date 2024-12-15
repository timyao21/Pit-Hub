//
//  ScheduleList.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/12/24.
//

import SwiftUI

struct ScheduleList: View {
    
    private let scheduleManager: ScheduleManager
    
    @State private var upcomingMeetings = [Meeting]()
    @State private var pastMeetings = [Meeting]()
    
    var body: some View {
        NavigationSplitView{
            VStack{
                if !upcomingMeetings.isEmpty {
                    Text("接下来...")
                        .font(.custom(S.smileySans, size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                    List(upcomingMeetings) { meeting in
                        NavigationLink {
                            ScheduleDetail(meeting: meeting)
                        } label: {
                            ScheduleRow(meeting: meeting)
                        }
                    }
                }
                
                Text("已结束...")
                    .font(.custom(S.smileySans, size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                
                if !pastMeetings.isEmpty {
                    List(pastMeetings) { meeting in
                        NavigationLink {
                            ScheduleDetail(meeting: meeting)
                        } label: {
                            ScheduleRow(meeting: meeting)
                        }
                    }
                } else {
                    Text("No past meetings")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
        } detail: {
            Text("Select a Schedule")
        }
        .onAppear {
            fetchMeetings()
        }
    }
    
    init(scheduleManager: ScheduleManager) {
        self.scheduleManager = scheduleManager
    }
    
    func fetchMeetings() {
        scheduleManager.getUpcomingMeetings { meetings in
            DispatchQueue.main.async {
                self.upcomingMeetings = meetings ?? []
            }
        }
        
        scheduleManager.getPastMeetings { meetings in
            DispatchQueue.main.async {
                self.pastMeetings = meetings ?? []
            }
        }
    }
    
}

#Preview {
    ScheduleList(scheduleManager: ScheduleManager(year: 2023))
}
