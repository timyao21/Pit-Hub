//
//  BottomNavBarIndexViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import Foundation


class IndexViewModel: ObservableObject {
    // MARK: - Data Manager
    private let driverStandingsManager = DriverStandingsManager()
    private let constructorStandingsManager = ConstructorStandingsManager()
    
    @Published var driverStanding: [DriverStanding] = []
    @Published var constructorStanding: [ConstructorStanding] = []
    @Published var standingViewYear: String = "2024"
    
    
    // MARK: - Load Standings Data
    func loadStandingsData() {
        Task {
            await fetchDriverStanding()
            await fetchConstructorStanding()
        }
    }
    
    func refreshData() async {
        print("Refreshing standings data...")
        await fetchDriverStanding()
        await fetchConstructorStanding()
    }
    
    // MARK: - Change the Calendar Year
    func updateStandingViewYear(year: String) {
        self.standingViewYear = year
    }
    
    // MARK: - Fetch Driver Standing
    func fetchDriverStanding() async {
        do {
//            self.driverStanding = try await driverStandingsManager.fetchDriverStandings(for: "2024")
            let fetchedStandings = try await driverStandingsManager.fetchDriverStandings(for: "2024")
            
            DispatchQueue.main.async {
                self.driverStanding = fetchedStandings
            }
        } catch {
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Constructor Standing
    func fetchConstructorStanding() async {
        do {
            let constructorStandingList = try await constructorStandingsManager.fetchConstructorStandings(for: "2024")
            
//            // Safely unwrap first element
//            guard let firstStandingList = constructorStandingList.first else {
//                print("No constructor standings data available.")
//                self.constructorStanding = [] // Ensure it's set to an empty array
//                return
//            }
//            
//            // Get the list of Constructor Standing
//            self.constructorStanding = firstStandingList.constructorStandings
            DispatchQueue.main.async {
                self.constructorStanding = constructorStandingList.first?.constructorStandings ?? []
            }
        } catch {
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    // MARK: - End
    
}


