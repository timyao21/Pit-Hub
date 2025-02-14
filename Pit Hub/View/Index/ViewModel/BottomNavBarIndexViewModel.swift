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
    @Published var scheduleViewYear: String = "2024"
    
    
    // MARK: - Load Standings Data
    func loadStandingsData() {
        Task {
            await fetchDriverStanding()
            await fetchConstructorStanding()
        }
    }
    // MARK: - Able to refreshData the data
    func refreshData() async {
        print("Refreshing standings data...")
        await fetchDriverStanding()
        await fetchConstructorStanding()
    }
    
    // MARK: - Change the Calendar Year
    func updateStandingViewYear(for year: String) {
        self.standingViewYear = year
        Task {
            await refreshData()
        }
    }
    
    // MARK: - Fetch Driver Standing
    func fetchDriverStanding() async {
        do {
            let fetchedStandings = try await driverStandingsManager.fetchDriverStandings(for: standingViewYear)
            
            DispatchQueue.main.async {
                self.driverStanding = fetchedStandings
            }
        } catch {
            self.driverStanding = []
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Constructor Standing
    func fetchConstructorStanding() async {
        do {
            let constructorStandingList = try await constructorStandingsManager.fetchConstructorStandings(for: standingViewYear)
            DispatchQueue.main.async {
                self.constructorStanding = constructorStandingList.first?.constructorStandings ?? []
            }
        } catch {
            self.constructorStanding = []
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }    
    // MARK: - End
    
}


