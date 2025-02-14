//
//  HomeViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import Foundation

extension HomeView {
    class ViewModel: ObservableObject {
        private let gpManager = GPManager()
        @Published var gps: [GP] = []
        @Published var allUpcomingGP: [GP] = []
        @Published var upcomingGP: GP?
        @Published var pastGP: [GP] = []
        
        func loadAllGP() {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
            let today = Date()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: today)
            
            Task {
                do {
                    let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
                    
                    // Ensure correct date conversion
                    gps = allGPs
                    
                    allUpcomingGP = allGPs.filter { gp in
                        if let gpDate = dateFormatter.date(from: gp.date) {
                            return gpDate >= today
                        }
                        return false
                    }
                    
                    pastGP = allGPs.filter { gp in
                        if let gpDate = dateFormatter.date(from: gp.date) {
                            return gpDate < today
                        }
                        return false
                    }

                    // Print debug info
                    upcomingGP = allUpcomingGP.first
                    print("Upcoming GPs: \(allUpcomingGP.count)")
                    print("Past GPs: \(pastGP.count)")
                    
                } catch {
                    print("Failed to fetch races: \(error.localizedDescription)")
                }
            }
        }
        
    }
}
