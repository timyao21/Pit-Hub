//
//  HomeView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Image(S.pitIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                Text(S.title)
                    .foregroundColor(Color(S.pitHubIconColor))
                    .font(.custom(S.orbitron, size: 30))
                    .bold()
                Spacer()
            }
            .padding()

            if let upcomingMeeting = viewModel.upcomingMeetings.first {
                HomeRaceRow(meeting: upcomingMeeting)
                    .padding()
            } else {
                Text("暂无日程")
            }
//            if viewModel.pastMeetings.indices.contains(1) {
//                let pastMeeting = viewModel.pastMeetings[4]
//                HomeRaceRow(meeting: pastMeeting)
//                    .padding(.top, 0)
//                    .padding(.horizontal)
//            } else {
//                Text("No Past Meetings")
//            }
        }
        .background(Color(S.primaryBackground))
        .onAppear {
            viewModel.loadMeetings()
        }
    }
}

#Preview {
    HomeView()
}
