//
//  RaceCalendarDetailViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/21/25.
//

import Foundation

extension RaceCalendarDetailView{
    @MainActor
    @Observable class RaceCalendarDetailViewModel {
        private let gpManager = GPManager()
        var year: String
        var raceRound: String
        
        var raceResults: [Results] = []
        var qualifyingResults: [QualifyingResults] = []
        var sprintResults: [SprintResults] = []
        
        init(year: String, raceRound: String) {
            self.year = year
            self.raceRound = raceRound
        }
        
        func fetchRaceResults(for year: String, raceRound: String) async {
            print("Fetching \(year) Round \(raceRound)...")
            
            // Run both calls concurrently, converting errors to nil.
            async let raceResults = try? gpManager.fetchRaceResults(for: year, round: raceRound)
            async let qualifyingResults = try? gpManager.fetchQualifyingResults(for: year, round: raceRound)
            async let sprintResults = try? gpManager.fetchSprintResults(for: year, round: raceRound)
            
            // Await both results concurrently.
            let allRaceResults = await raceResults
            let allQualifyingResults = await qualifyingResults
            let allSprintResults = await sprintResults
            
            // Ensure that updates happen on the main thread
            if let results = allRaceResults {
                self.raceResults = results
            } else {
                print("Failed to fetch race results")
            }
            
            if let results = allQualifyingResults {
                self.qualifyingResults = results
            } else {
                print("Failed to fetch qualifying results")
            }
            
            if let sprintResults = allSprintResults {
                self.sprintResults = sprintResults
            } else{
                print( "Failed to fetch sprint results")
            }
        }
        
        // MARK: - End

    }
}
