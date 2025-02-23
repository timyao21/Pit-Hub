//
//  RaceCalendarDetailViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/21/25.
//

import Foundation


extension RaceCalendarDetailView{
    class RaceCalendarDetailViewModel: ObservableObject {
        private let gpManager = GPManager()
        @Published var year: String
        @Published var raceRound: String
        
        @Published var raceResults: [Results] = []
        @Published var qualifyingResults: [QualifyingResults] = []
        
        init(year: String, raceRound: String) {
            self.year = year
            self.raceRound = raceRound
        }
        
        func fetchRaceResults(for year: String, raceRound: String) async {
            // Implement your API call here
            print("Fetching\(year) Round\(raceRound)...")
            do{
                let allRaceResults = try await gpManager.fetchRaceResults(for: year, round: raceRound)
                let allQualifyingResults = try await gpManager.fetchQualifyingResults(for: year, round: raceRound)
                DispatchQueue.main.async {
                    self.raceResults = allRaceResults
                    self.qualifyingResults = allQualifyingResults
                }
                
            }catch {
                print("Failed to fetch races: \(error.localizedDescription)")
            }
            
        }
        
    }
}
