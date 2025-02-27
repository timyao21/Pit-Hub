//
//  DriverDetailView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/27/25.
//

import Foundation
import SwiftUI

@MainActor
extension DriverDetailView {
    class DriverDetailViewModel: ObservableObject{
        
        @Published var driverRaceResult: [Races] = []
        @Published var driverRaceResultPositionChart: [PositionChart] = []
        private let DriverManager = DriverStandingsManager()
        
        // MARK: - Fetch Driver Results
        
        func fetchDriverResults(for year: String, driverID: String) async {
            print("Fetching \(year) result for \(driverID)...")
            
            async let fetchedResults = try? DriverManager.fetchDriverRaceResult(for: year, driverID: driverID)
            
            let driverResult = await fetchedResults
            
            // Ensure that updates happen on the main thread
            await MainActor.run {
                if let results = driverResult {
                    self.driverRaceResult = results
                    for result in self.driverRaceResult {
                        let chartData = PositionChart(year: results.first?.season ?? " ", driverName: result.results?.first?.driver.familyName ?? " ", driverNumber: result.results?.first?.number, round: result.round, position: result.results?.first?.position ?? " ")
                        print("\(chartData)")
                    }
                } else {
                    print("Failed to fetch \(driverID) results")
                }
            }
        }
        
        
        // MARK: - End
        

    }
}
