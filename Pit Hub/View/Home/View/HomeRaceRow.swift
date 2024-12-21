//
//  HomeRaceRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct HomeRaceRow: View {
    
    var meeting: Meeting
    
    @StateObject var viewModel = ViewModel()
    @State var displaySessions:  [Session] = []
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack(alignment: .leading){
                    Text("\(meeting.circuitShortName)")
                    Text("\(CountryNameTranslator.translate(englishName: meeting.circuitShortName))")
                        .font(.custom(S.smileySans, size: 40))
                }
                Spacer()
                Image(meeting.circuitShortName)
                    .resizable()
                    .renderingMode(.template) // Makes the image render as a template
                    .scaledToFit()
                    .frame(width: 150)
                    .foregroundColor(Color("circuitColor")) // Applies the color to the image
            }
            .font(.custom(S.smileySans, size: 20))
            
            HStack{
                VStack(){
                    Group{
                        Text("排位 & 正赛")
                            .font(.custom(S.smileySans, size: 20))
                        Text("所有时间均为设备本地时区")
                            .font(.custom(S.smileySans, size: 12))
                            .padding(.vertical, 3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                Toggle(isOn: $viewModel.isPracticeVisible) { // Bind to the state variable
                    Text("显示练习赛")
                        .font(.custom(S.smileySans, size: 15))
                }
                .tint(Color(S.pitHubIconColor))
                .toggleStyle(.button)
                .padding()
            }
            if viewModel.isPracticeVisible {
                List(viewModel.sessions) { session in
                    ScheduleSessionRowView(session: session)
                        .listRowBackground(Color(S.primaryBackground))
                }
                .listStyle(.plain)
                .listRowSpacing(5)
            }
            else {
                List(viewModel.filteredSessions) { session in
                    ScheduleSessionRowView(session: session)
                        .listRowBackground(Color(S.primaryBackground))
                }
                .listStyle(.plain)
                .listRowSpacing(20)
            }
            
        }
        .background(Color(S.primaryBackground))
        .onAppear {
            viewModel.fetchSessions(meeting.meetingKey, for: meeting.dateStart)
        }
    }
}

#Preview {
    HomeRaceRow(meeting:Meeting(
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
    ))
}
