//
//  DriverDetailView-ViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/27/25.
//

import Foundation
import SwiftUI

extension DriverDetailView {
    @Observable class ViewModel{
        private let driverManager = DriverStandingsManager()
        
        @MainActor var driverRaceResult: [Races] = []
        @MainActor var driverRaceResultPositionChart: [PositionChart] = []
        
        // MARK: - Fetch Driver Results
        @MainActor
        func fetchDriverResults(for year: String, driverID: String) async {
            print("Fetching \(year) result for \(driverID)...")
            
            guard let results = try? await driverManager.fetchDriverRaceResult(for: year, driverID: driverID) else {
                print("Failed to fetch \(driverID) results")
                return
            }
            
            driverRaceResult = results
            
            // Build the position chart data in a single pass
            driverRaceResultPositionChart = results.map { result in
                // Assuming that the season is constant across results; if not, adjust as needed.
                let season = results.first?.season ?? " "
                let driverName = result.results?.first?.driver.familyName ?? " "
                let driverNumber = result.results?.first?.number
                let round = result.round
                let circuitId = result.circuit.circuitId
                let position = result.results?.first?.position ?? " "
                
                return PositionChart(
                    year: season,
                    driverName: driverName,
                    driverNumber: driverNumber,
                    round: round,
                    circuitId: circuitId,
                    position: position
                )
            }
            .sorted { firstChart, secondChart in
                // Safely convert the round strings to integers for sorting
                if let round1 = Int(firstChart.round), let round2 = Int(secondChart.round) {
                    return round1 < round2
                }
                return false
            }
        }
        
        
        // MARK: - End
        
    }
}
