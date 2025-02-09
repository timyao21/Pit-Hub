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
        
        private let manager = FirestoreDriversManager()
        
        @Published var selectedYear = 2024
        @Published var F1Drivers: [F1Driver] = []
        
        // MARK: - Change the Calendar Year
        func changeYear(year: Int) {
            self.selectedYear = year
        }
        
        // MARK: - Load Driver
        func loadDrivers(for year: Int) {
            Task {
                do {
                    let fetchedDrivers = try await manager.fetchDrivers(for: year)
                    self.F1Drivers = fetchedDrivers // Updates UI automatically
                } catch {
                    print("Error fetching drivers: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
