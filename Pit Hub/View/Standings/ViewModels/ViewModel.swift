//
//  StandingsViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 5/1/25.
//

import Foundation

extension StandingsView {
    @Observable class ViewModel{
        // MARK: - Data Manager
        private let driverStandingsManager = DriverStandingsManager()
        private let constructorStandingsManager = ConstructorStandingsManager()
        
        @MainActor var standingViewYear : String
        @MainActor var driverStandings: [DriverStanding] = []
        @MainActor var constructorStandings: [ConstructorStanding] = []
        
        // MARK: - Init the viewModel for standings
        @MainActor
        init(year: String = String(Calendar.current.component(.year, from: .now))) {
            self.standingViewYear = year
            Task {                                       // inherits MainActor
                await refresh()                          // wait for fetch
                print("StandingsViewModel ---- Init")
            }
        }
        
        // MARK: - refresh the page
        @MainActor
        func refresh() async{
            print("StandingsViewModel ---- Refresh")
            do {
                async let drv = driverStandingsManager.fetchDriverStandings(for: standingViewYear)
                async let con = constructorStandingsManager.fetchConstructorStandings(for: standingViewYear)
                (driverStandings, constructorStandings) = try await (drv, con)
            } catch {
                driverStandings = []
                constructorStandings = []
                print("🔴 fetch failed:", error)
            }
            
        }
        
        // MARK: - update the year and refesh the page
        @MainActor
        func updateStandingViewYear(for newYear: String) async{
            guard newYear == standingViewYear else { return }
            standingViewYear = newYear
            Task {                                       // inherits MainActor
                await refresh()                          // wait for fetch
            }
        }
        
    }
}
