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
            .padding()
            Spacer()
            Button("Load Meetings") {
                viewModel.loadMeetings()
            }
            Text("Past Meetings: \(viewModel.pastMeetings.last?.meetingName ?? "No Meeting")")
            Text("Upcoming Meetings: \(viewModel.upcomingMeetings.first?.meetingName ?? "No Meeting")")
            Spacer()
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
