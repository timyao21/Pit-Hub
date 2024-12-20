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
                    .font(.system(size: 30))
                    .bold()
                Spacer()
                NavigationLink(destination: LoginView()) {
                    Text("登录")
                        .font(.custom(S.smileySans, size: 17))
                }
                .font(.system(size: 15))
                .foregroundColor(Color(S.pitHubIconColor))
            }
            .padding(.vertical, 0)
            .padding(.horizontal, 10)

            if let upcomingMeeting = viewModel.upcomingMeetings.first {
                HomeRaceRow(meeting: upcomingMeeting)
                    .padding(.top, 0)
                    .padding(.horizontal)
            } else {
                Text("No Past Meetings")
            }
            if viewModel.pastMeetings.indices.contains(1) {
                let pastMeeting = viewModel.pastMeetings[4]
                HomeRaceRow(meeting: pastMeeting)
                    .padding(.top, 0)
                    .padding(.horizontal)
            } else {
                Text("No Past Meetings")
            }
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
