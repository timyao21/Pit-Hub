////
////  HomeView-ViewModel.swift
////  Pit Hub
////
////  Created by Junyu Yao on 5/3/25.
////

import Foundation
import StoreKit


extension HomeView {
    @Observable class ViewModel {
        // MARK: - Properties
        
        // Data Manager
        private let gpManager = GPManager()
        
        // Home View Properties
        @MainActor var homepageRaces: [Races] = []
        @MainActor var homepagePastRaces: [Races] = []
        @MainActor var homepageUpcomingRaces: [Races] = []
        @MainActor var homepageUpcomingRace: Races?
        
        //Race Calendar View Properties
        @MainActor var scheduleRaces: [Races] = []
        @MainActor var schedulePastRaces: [Races] = []
        @MainActor var scheduleUpcomingRaces: [Races] = []

        
        @MainActor
        init() {
            Task {
                await loadAllGP()
                print("HomeViewModel ---- init")
            }
        }
        
        @MainActor
        func loadAllGP() async {
            let today = Date()
            let currentYear = Calendar.current.component(.year, from: today)
            
            do{
                let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
                homepageRaces = allGPs
                scheduleRaces = allGPs
                
                // Split races into upcoming and past in one pass
                var upcoming = [Races]()
                var past = [Races]()
                for gp in allGPs {
                    if let gpDate = DateUtilities.combineDate(from: gp.date, and: gp.time ?? " ") {
                        if gpDate >= today {
                            upcoming.append(gp)
                        } else {
                            past.append(gp)
                        }
                    }
                }
                
                homepagePastRaces = past
                homepageUpcomingRaces = upcoming
                homepageUpcomingRace = upcoming.first
                
                schedulePastRaces = past
                scheduleUpcomingRaces = upcoming
                
            }
            catch {
                print("Failed to fetch races: \(error)")
            }
        }
        
        @MainActor
        func refreshHomepage() async {
            let today = Date()
            let currentYear = Calendar.current.component(.year, from: today)
            
            do{
                let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
                homepageRaces = allGPs
                
                // Split races into upcoming and past in one pass
                var upcoming = [Races]()
                var past = [Races]()
                for gp in allGPs {
                    if let gpDate = DateUtilities.combineDate(from: gp.date, and: gp.time ?? " ") {
                        if gpDate >= today {
                            upcoming.append(gp)
                        } else {
                            past.append(gp)
                        }
                    }
                }

                homepagePastRaces = past
                homepageUpcomingRaces = upcoming
                homepageUpcomingRace = upcoming.first
                
            }
            catch {
                print("Failed to fetch races: \(error)")
            }
            
        }
        
    }
}
