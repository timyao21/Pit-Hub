//
//  RaceCalendarDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/21/25.
//

import SwiftUI

// MARK: - Tab Model

enum ResultType {
    case race, quali, sprint, sprintQuali
}

struct ResultTab: Identifiable {
    let id = UUID()
    let title: String
    let type: ResultType
}

struct RaceCalendarDetailView: View {
    
    
    @State var viewModel: RaceCalendarDetailViewModel
    @State private var showFullResults: Bool = false
    @State private var selectedTab: ResultType = .race
    private let homepage: Bool
    let race: Races?
    
    init(for race: Races) {
        viewModel = RaceCalendarDetailViewModel(year: race.season, raceRound: race.round)
        self.race = race
        self.homepage = false
    }
    
    init(for race: Races, homepage: Bool) {
        viewModel = RaceCalendarDetailViewModel(year: race.season, raceRound: race.round)
        self.race = race
        self.homepage = homepage
    }
    
    // Compute available tabs based on which data is present.
    private var availableTabs: [ResultTab] {
        var tabs = [ResultTab]()
        if !viewModel.raceResults.isEmpty {
            tabs.append(ResultTab(title: "Race", type: .race))
        }
        if !viewModel.qualifyingResults.isEmpty {
            tabs.append(ResultTab(title: "Quali", type: .quali))
        }
        if !viewModel.sprintResults.isEmpty {
            tabs.append(ResultTab(title: "Sprint", type: .sprint))
        }
        // Uncomment if you have sprint qualifying data:
        // if !viewModel.sprintQualiResults.isEmpty {
        //     tabs.append(ResultTab(title: "Sprint Quali", type: .sprintQuali))
        // }
        return tabs
    }
    
    // Helper to build the results view for a given type.
    @ViewBuilder
    private func resultsView(for type: ResultType) -> some View {
        switch type {
        case .race:
            ResultList(length: 10, results: viewModel.raceResults)
        case .quali:
            ResultList(length: 10, results: viewModel.qualifyingResults)
        case .sprint:
            ResultList(length: 10, results: viewModel.sprintResults)
        case .sprintQuali:
            // Replace with your sprint quali view if available.
            Text("Sprint Quali Results")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                RaceSection(for: race)
                
                if !availableTabs.isEmpty {
                    // Display the tab titles using your custom subtab selector.
                    // (For simplicity, here we build a basic horizontal list.)
                    // Tab buttons
                    HStack(alignment: .center) {
                        PitSubtitle(for: "Results")
                            .bold()
                            .foregroundColor(Color(S.pitHubIconColor))
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(availableTabs) { tab in
                                    Button {
                                        selectedTab = tab.type
                                    } label: {
                                        Text(LocalizedStringKey(tab.title))
                                            .bold()
                                            .foregroundColor(selectedTab == tab.type ? Color(S.pitHubIconColor) : .secondary)
                                            .padding(5)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(selectedTab == tab.type ? Color.gray.opacity(0.2) : Color.clear)
                                            )
                                    }
                                }
                            }
                        }
                        
                        Button(action: {
                            showFullResults.toggle()
                        }) {
                            HStack {
                                Text("Full")
                                Image(systemName: "chevron.up.2")
                                    .imageScale(.small)
                            }
                            .bold()
                            .padding(3)
                            .foregroundColor(Color(S.pitHubIconColor).opacity(0.7))
                            .cornerRadius(5)
                        }
                    }
                    
                    // The TabView uses the available tabs.
                    TabView(selection: $selectedTab) {
                        ForEach(availableTabs) { tab in
                            ForEach(availableTabs) { tab in
                                resultsView(for: tab.type)
                                    .tag(tab.type)
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 200)
                    .animation(.easeInOut, value: selectedTab)
                    
                }else{
                    VStack{
                        HStack{
                            PitSubtitle(for: "Results")
                                .bold()
                                .foregroundColor(Color(S.pitHubIconColor))
                            Spacer()
                        }
                        Spacer()
                        Text("The red light is still on in the pit lane - Data is Unavailable")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(height: 200)
                }
                if homepage == false {
                    PitSubtitle(for: "Circuit Location")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let lat = race?.circuit.location.lat,
                       let long = race?.circuit.location.long,
                       lat != "0", long != "0" {
                        CircuitMapView(lat: lat, long: long)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchRaceResults(for: viewModel.year, raceRound: viewModel.raceRound)
                // After loading, if no tab is selected, default to the first available.
                if availableTabs.first?.type != nil {
                    selectedTab = availableTabs.first!.type
                }
            }
        }
        .sheet(isPresented: $showFullResults) {
            // Show the full results view based on the selected tab.
            switch selectedTab {
            case .race:
                FullResultsListView(
                    raceName: race?.raceName ?? "",
                    season: race?.season ?? "",
                    round: race?.round ?? "",
                    date: race?.date ?? "",
                    time: race?.time ?? "",
                    raceResult: viewModel.raceResults
                )
            case .quali:
                FullResultsListView(
                    raceName: race?.raceName ?? "",
                    season: race?.season ?? "",
                    round: race?.round ?? "",
                    date: race?.date ?? "",
                    time: race?.time ?? "",
                    qualifyingResult: viewModel.qualifyingResults
                )
            case .sprint:
                FullResultsListView(
                    raceName: race?.raceName ?? "",
                    season: race?.season ?? "",
                    round: race?.round ?? "",
                    date: race?.date ?? "",
                    time: race?.time ?? "",
                    sprintResult: viewModel.sprintResults
                )
            case .sprintQuali:
                FullResultsListView(
                    raceName: race?.raceName ?? "",
                    season: race?.season ?? "",
                    round: race?.round ?? "",
                    date: race?.date ?? "",
                    time: race?.time ?? "",
                    qualifyingResult: [] // Replace with actual data if available.
                )
            }
        }
    }
}

#Preview {
    RaceCalendarDetailView(for: Races.sample)
}
