//
//  RaceCalendarDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/21/25.
//

import SwiftUI

struct RaceCalendarDetailView: View {
    
    @ObservedObject var viewModel: RaceCalendarDetailViewModel
    let race: Races?
    
    
    private let resultsTabTitles = ["Race", "Qualifying"]
    private let resultsTabTitlesSprint = ["Sprint", "Sprint Quali"]
    
    @State private var raceTab = 0
    @State private var sprintTab = 0
    
    
    init(for race: Races) {
        viewModel = RaceCalendarDetailViewModel(year: race.season, raceRound: race.round)
        self.race = race
    }
    
    var body: some View {
        VStack{
            RaceSection(for: race)
            HStack(spacing: 0){
                PitSubtitle(for: "Race Results")
                Text("Full Results")
                    .font(.custom(S.smileySans, size: 16))
                    .foregroundColor(Color(S.pitHubIconColor))
                    .padding(.leading, 10)
            }
            .padding(.vertical)
            
            SubTabSelector(selectedTab: $raceTab, tabTitles: resultsTabTitles)
            TabView(selection: $raceTab){
                ResultList(length: 10,results: viewModel.raceResults)
                    .tag(0)
                Text("q1")
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            
            if ((race?.sprint) != nil){
                SubTabSelector(selectedTab: $sprintTab, tabTitles: resultsTabTitlesSprint)
            }
            PitSubtitle(for: "Location")
            
        }
        .onAppear {
            Task {
                await viewModel.fetchRaceResults(for: viewModel.year, raceRound: viewModel.raceRound)
            }
        }
    }
}

#Preview {
    RaceCalendarDetailView(for: Races.sample)
}
