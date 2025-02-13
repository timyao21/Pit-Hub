//
//  StandingsViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/15/25.
//
//import Foundation
//
//@MainActor
//extension StandingsViewOld {
//    class ViewModel: ObservableObject {
//        
//        private let manager = FirestoreDriversManager()
//        
//        @Published var selectedYear = 2024
//        @Published var F1Drivers: [F1Driver] = []
//        @Published var F1Teams: [F1Team] = []
//        
//        // MARK: - Change the Calendar Year
//        func changeYear(year: Int) {
//            self.selectedYear = year
//        }
//        
//        // MARK: - Load Driver
//        func loadDrivers(for year: Int) {
//            Task {
//                do {
//                    let fetchedDrivers = try await manager.fetchDrivers(for: year)
//                    let fetchedTeams = try await manager.fetchTeam(for: year)
//                    self.F1Drivers = fetchedDrivers // Updates UI automatically
//                    self.F1Teams = fetchedTeams
//                } catch {
//                    print("Error fetching drivers: \(error.localizedDescription)")
//                }
//            }
//        }
//        
//    }
//}
