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
        private let constructorStandingsManager = ConstructorStandingsManager()
        
        @Published var driverStanding: [DriverStanding] = []
        @Published var constructorStanding: [ConstructorStanding] = []
        @Published var year: String = "2024"
        
        func loadData() {
            Task {
                await fetchDriverStanding()
                await fetchConstructorStanding()
            }
        }
        

        // MARK: - Fetch Driver Standing
        func fetchDriverStanding() async {
            Task {
                do {
                    driverStanding = try await driverStandingsManager.fetchDriverStandings(for: "2024")
                } catch {
                    print("Failed to fetch driver standings: \(error.localizedDescription)")
                }
            }
        }
        
        // MARK: - Fetch Constructor Standing
        func fetchConstructorStanding() async {
            Task {
                do {
                    let constructorStandingList = try await constructorStandingsManager.fetchConstructorStandings(for: "2024")
                    
                    // Safely unwrap first element
                    guard let firstStandingList = constructorStandingList.first else {
                        print("No constructor standings data available.")
                        constructorStanding = [] // Ensure it's set to an empty array
                        return
                    }
                    
                    // Get the list of Constructor Standing
                    constructorStanding = firstStandingList.constructorStandings
                } catch {
                    print("Failed to fetch driver standings: \(error.localizedDescription)")
                }
            }
        }
                
    }
}
