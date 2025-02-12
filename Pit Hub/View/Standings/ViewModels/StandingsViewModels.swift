//
//  StandingsViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/15/25.
//
import Foundation

@MainActor
extension StandingsView {
    class ViewModel: ObservableObject {
        
        private let driverStandingsManager = DriverStandingsManager()
        
        @Published var driverStanding: [DriverStanding] = []
        @Published var year: String = "2024"
        
        func fetchDriverStanding() {
            Task {
                do {
                    driverStanding = try await driverStandingsManager.fetchDriverStandings(for: "2024")
                } catch {
                    print("Failed to fetch driver standings: \(error.localizedDescription)")
                }
            }
        }
                
    }
}
