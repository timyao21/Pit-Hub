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
    
    @State private var showFullResults: Bool = false
    private let resultsTabTitles = ["Race", "Qualifying"]
    private let resultsTabTitlesSprint = ["Sprint", "Sprint Quali"]
    
    @State private var raceTab = 0
    @State private var sprintTab = 0
    
    
    init(for race: Races) {
        viewModel = RaceCalendarDetailViewModel(year: race.season, raceRound: race.round)
        self.race = race
    }
    
    var body: some View {
        ScrollView{
            VStack{
                
                RaceSection(for: race)
                
                if !viewModel.raceResults.isEmpty && !viewModel.qualifyingResults.isEmpty {
                    HStack(spacing: 0){
                        PitSubtitle(for: "Race Results")
                        Button(action: {
                            showFullResults.toggle()
                        }) {
                            Text("Full")
                                .font(.custom(S.smileySans, size: 16))
                                .foregroundColor(Color(S.pitHubIconColor))
                                .padding(.leading, 10)
                            Image(systemName: "arrow.up.forward")
                                .imageScale(.small)
                                .foregroundColor(Color(S.pitHubIconColor))
                        }
                    }
                    .padding(.vertical)
                    
                    SubTabSelector(selectedTab: $raceTab, tabTitles: resultsTabTitles)
                    
                    TabView(selection: $raceTab){
                        ResultList(length: 10,results: viewModel.raceResults)
                            .tag(0)
                        ResultList(length: 10,results: viewModel.qualifyingResults)
                            .tag(1)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 188)
                    
                    
                }
                
                if ((race?.sprint) != nil){
                    SubTabSelector(selectedTab: $sprintTab, tabTitles: resultsTabTitlesSprint)
                }
                
                PitSubtitle(for: "Location")
                if let lat = race?.circuit.location.lat,
                   let long = race?.circuit.location.long,
                   lat != "0", long != "0" {
                    CircuitMapView(lat: lat, long: long)
                }
                
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchRaceResults(for: viewModel.year, raceRound: viewModel.raceRound)
            }
        }
        .sheet(isPresented: $showFullResults) {
            FullRaceResultListView(raceName: race?.raceName ?? "",season: race?.season ?? "", round: race?.round ?? "", time: race?.time ?? "", raceResult: viewModel.raceResults)
        }
    }
}

#Preview {
    RaceCalendarDetailView(for: Races.sample)
}
