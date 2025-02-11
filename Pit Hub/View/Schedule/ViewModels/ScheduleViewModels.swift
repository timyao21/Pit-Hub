//
//  ScheduleViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/17/24.
//

import Foundation
import MapKit

extension ScheduleListView {
    class ViewModel: ObservableObject{
        // MARK: - Propertiesf
        private let manager = FirestoreDriversManager()
        @Published var F1GP: [GrandPrix] = []
        @Published var upcomingF1GP: [GrandPrix] = []
        @Published var pastF1GP: [GrandPrix] = []
        
        @Published var year: Int = Calendar.current.component(.year, from: Date())
        
        // MARK: - Change the Calendar Year
        func changeYear(year: Int) {
            self.year = year
            loadAllGP()
        }
        
        // MARK: - Load the GP from firebase
        func loadAllGP() {
//            let today = Calendar.current.startOfDay(for: Date())
            let today = Calendar.current.startOfDay(for: {
                var components = DateComponents()
                components.year = 2024
                components.month = 7
                components.day = 15
                return Calendar.current.date(from: components) ?? Date()
            }())
            
            Task {
                do {
                    let fetchedGP = try await manager.fetchGrandPrix(for: year)
                    // If fetchedGP is empty, set self.F1GP to an empty list
                    guard !fetchedGP.isEmpty else {
                        self.F1GP = []
                        self.pastF1GP = []
                        self.upcomingF1GP = []
                        return
                    }
                    
                    // Convert all fetchedGP dates (String) to local timezone and update GrandPrix instances
                    let localGP = fetchedGP.map { gp -> GrandPrix in
                        var updatedGP = gp
                        if let date = DateUtils.convertStringToLocalDate(gp.dateStart) {
                            updatedGP.dateStart = DateUtils.formatDateToString(date) // Convert back to a formatted String if needed
                        }
                        return updatedGP
                    }
                    
                    // Update F1GP with converted dates
                    self.F1GP = localGP
                    
                    // Convert localGP date strings into Date objects for comparison
                    self.pastF1GP = localGP.filter {
                        if let date = DateUtils.convertStringToLocalDate($0.dateStart) {
                            return date < today // Past races
                        }
                        return false
                    }
                    
                    self.upcomingF1GP = localGP.filter {
                        if let date = DateUtils.convertStringToLocalDate($0.dateStart) {
                            return date >= today // Upcoming races
                        }
                        return false
                    }
                    
                    print("Fetched \(F1GP.count) Grand Prix races.")
                    print("Past Races: \(pastF1GP.count), Upcoming Races: \(upcomingF1GP.count)")
                    
                } catch {
                    print("Error fetching drivers: \(error.localizedDescription)")
                }
            }
            
        }
    }
}
