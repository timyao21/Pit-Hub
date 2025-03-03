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
    let race: Races?
    
    // Use one state to control showing the full results sheet.
    @State private var showFullResults: Bool = false
    // This will hold the ID of the currently selected tab.
    @State private var selectedTab: ResultType = .race
    
    init(for race: Races) {
        viewModel = RaceCalendarDetailViewModel(year: race.season, raceRound: race.round)
        self.race = race
    }
    
    // Compute available tabs based on which data is present.
    var availableTabs: [ResultTab] {
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
                                        Text(NSLocalizedString(tab.title, comment: "Localized title text"))
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
                                Text(NSLocalizedString("Full", comment: "Localized title text"))
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
                            Group {
                                switch tab.type {
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
                            .tag(tab.type)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 200)
                    .animation(.easeInOut, value: selectedTab)
                }
                
                PitSubtitle(for: "Circuit Location")
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                    sprintResult: [] // Replace with actual data if available.
                )
            }
        }
    }
}

#Preview {
    RaceCalendarDetailView(for: Races.sample)
}
