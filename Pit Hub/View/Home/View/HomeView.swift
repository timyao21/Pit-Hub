//
//  HomeView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = ViewModel()
    @State private var showSetting = false
    
    var body: some View {
        VStack(spacing: 0){
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
                Button{
                    showSetting.toggle()
                } label: {
                    Image(systemName: "flag.2.crossed.fill")
                        .foregroundStyle(Color(S.pitHubIconColor))
                }
            }
            .padding()
            // MARK: - UP Coming Race
            if let upcomingMeeting = viewModel.upcomingMeetings.first {
                HomeRaceRow(meeting: upcomingMeeting)
                    .padding()
            } else {
                Text("暂无日程")
                Spacer()
            }
            
            // MARK: - Weather
            if let upcomingMeeting = viewModel.upcomingMeetings.first {
                HomeWeatherRow(meeting: upcomingMeeting)
                    .padding(.horizontal, 0)
            } else {
                Text("暂无天气数据")
                Spacer()
            }
            
            
        }
        .sheet(isPresented: $showSetting) {
            ProfileView()
                .presentationBackground(Color(S.primaryBackground))
                .presentationCornerRadius(50)
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
