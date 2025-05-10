////
////  HomeView-ViewModel.swift
////  Pit Hub
////
////  Created by Junyu Yao on 5/3/25.
////

import Foundation
import StoreKit


@Observable class HomepageViewModel {
    // MARK: - Properties
    
    // Data Manager
    private let gpManager = GPManager()
    @MainActor var isLoading: Bool = true
    
    // Home View Properties
    @MainActor var homepageRaces: [Races] = []
    @MainActor var homepagePastRaces: [Races] = []
    @MainActor var homepageUpcomingRaces: [Races] = []
    @MainActor var homepageUpcomingRace: Races?
    
    //Race Calendar View Properties
    @MainActor var raceCalendarSelectedTab: Int = 1
    @MainActor var raceCalendarViewSelectedYear = "\(Calendar.current.component(.year, from: Date()))"
    @MainActor var scheduleRaces: [Races] = []
    @MainActor var raceCalendarPastRaces: [Races] = []
    @MainActor var raceCalendarUpcomingRaces: [Races] = []
    
    
    @MainActor
    init() {
        Task {
            self.isLoading = true
            await loadAllGP()
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
            self.isLoading = false
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
            
            raceCalendarPastRaces = past
            raceCalendarUpcomingRaces = upcoming
            
        }
        catch {
            print("Failed to fetch races: \(error)")
        }
    }
    
    // MARK: - Homepage
    
    
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
    
    // MARK: - Race Calendar View
    
    @MainActor
    func updateRaceCalendarViewYear(for year: String) {
        raceCalendarViewSelectedYear = year
        Task{
            await refreshRaceCalendarView()
        }
    }
    
    @MainActor
    func refreshRaceCalendarView() async {
        let today = Date()
        
        do{
            let allGPs = try await gpManager.fetchRaceSchedule(for: raceCalendarViewSelectedYear)
            scheduleRaces = allGPs
            
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
            
            raceCalendarPastRaces = past
            raceCalendarUpcomingRaces = upcoming
            
            //                Select the upcoming tab when the season starts
            if raceCalendarPastRaces.isEmpty{
                raceCalendarSelectedTab = 0
            }else{
                raceCalendarSelectedTab = 1
            }
            
        }catch {
            print("Failed to refresh race calendar view:  \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - end
    
    
}

