//
//  HomeRaceRow.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import SwiftUI

struct HomeRaceRowOld: View {
    
    var meeting: Meeting
    
    @StateObject var viewModel = ViewModel()
    @State var displaySessions:  [Session] = []
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack(alignment: .leading){
                    Text("\(CountryNameTranslator.translateFlags(countryCode: meeting.countryCode)) \(meeting.circuitShortName)")
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
                            .foregroundColor(Color(S.pitHubIconColor))
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
                .tint(Color("grayButton"))
                .toggleStyle(.button)
                .padding()
            }
            
            ScrollView {
                VStack {
                    ForEach(viewModel.isPracticeVisible ? viewModel.sessions : viewModel.filteredSessions) { session in
                        ScheduleSessionRowView(session: session)
                            .padding(.vertical, 5)
                            .background(Color(S.primaryBackground))
                    }
                }
                .padding()
            }
            .frame(maxHeight: viewModel.isPracticeVisible ? 270 : 210)
            .animation(.spring(response: 0.75, dampingFraction: 1, blendDuration: 1), value: viewModel.isPracticeVisible)
            
            
        }
        .background(Color(S.primaryBackground))
        .onAppear {
            viewModel.fetchSessions(meeting.meetingKey, for: meeting.dateStart)
        }
    }
}

#Preview {
    HomeRaceRowOld(meeting:Meeting(
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
