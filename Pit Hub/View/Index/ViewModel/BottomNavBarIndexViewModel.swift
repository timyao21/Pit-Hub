//
//  BottomNavBarIndexViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import Foundation

@Observable class IndexViewModel{
    // MARK: - Data Manager
    private let driverStandingsManager = DriverStandingsManager()
    private let constructorStandingsManager = ConstructorStandingsManager()
    private let gpManager = GPManager()
    
    // MARK: - Home View Properties
    @MainActor var allGP: [Races] = []
    @MainActor var allPastGP: [Races] = []
    @MainActor var allUpcomingGP: [Races] = []
    @MainActor var upcomingGP: Races?
    
    // MARK: - Race Calendar View Properties
    @MainActor var raceCalendarViewYear = "\(Calendar.current.component(.year, from: Date()))"
    @MainActor var raceCalendar: [Races] = []
    @MainActor var raceCalendarPast: [Races] = []
    @MainActor var raceCalendarUpcoming: [Races] = []
    var raceCalendarSelectedTab: Int = 1
    
    // MARK: - Standings View Properties
    @MainActor var standingViewYear = "\(Calendar.current.component(.year, from: Date()))"
    @MainActor var driverStanding: [DriverStanding] = []
    @MainActor var constructorStanding: [ConstructorStanding] = []
    
    // MARK: - Computed Property for DateFormatter
    private var isoDateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        return formatter
    }
    
    // MARK: - Home Page GP Data
    @MainActor
    init() {
        Task {
            await fetchAllGP() // Load data for both Homepage & Race Calendar
            await fetchDriverStanding() // Load standings data
            await fetchConstructorStanding() // Load standings data
            if driverStanding.isEmpty && constructorStanding.isEmpty {
                let currentYear = Calendar.current.component(.year, from: Date()) - 1
                await updateStandingViewYear(for: "\(currentYear)")
            }
        }
    }
    
    // MARK: - Load all the GP info (When lunch the app)
    @MainActor
    func fetchAllGP() async {
        let today = Date()
        let todayUTC = DateUtilities.convertToUTC(today)
        let currentYear = Calendar.current.component(.year, from: today)
        
        do {
            let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
            allGP = allGPs
            
            var upcoming = [Races]()
            var past = [Races]()
            
            // Split races into upcoming and past in one pass
            for gp in allGPs {
                if let gpDate = isoDateFormatter.date(from: gp.date) {
                    if gpDate >= todayUTC {
                        upcoming.append(gp)
                    } else {
                        past.append(gp)
                    }
                }
            }
            allUpcomingGP = upcoming
            allPastGP = past
            upcomingGP = upcoming.first
            
            // Update Race Calendar Data
            raceCalendar = allGPs
            raceCalendarUpcoming = upcoming
            raceCalendarPast = past
            
            if raceCalendarPast.isEmpty{
                raceCalendarSelectedTab = 0
            }
            
        } catch {
            print("Failed to fetch races: \(error.localizedDescription)")
        }
    }
    
    // MARK: - refrseh the Home page data
    @MainActor
    func refreshHomeGPData() async{
        let today = Date()
        let todayUTC = DateUtilities.convertToUTC(today)
        let currentYear = Calendar.current.component(.year, from: today)
        
        do {
            let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
            allGP = allGPs
            
            var upcoming = [Races]()
            for gp in allGPs {
                if let gpDate = isoDateFormatter.date(from: gp.date), gpDate >= todayUTC {
                    upcoming.append(gp)
                }
            }
            
            upcomingGP = upcoming.first
            
        } catch {
            print("Failed to fetch races: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Race calendar view
    @MainActor
    func updateRaceCalendarViewYear(for year: String) {
        raceCalendarViewYear = year
        Task{
            await refreshRaceCalendarData()
        }
    }
    
    @MainActor
    func refreshRaceCalendarData() async {
        print("Refreshing Calendar Data for \(raceCalendarViewYear)...")
        let today = Date()
        let todayUTC = DateUtilities.convertToUTC(today)
        
        do{
            let allGPs = try await gpManager.fetchRaceSchedule(for: raceCalendarViewYear)
            raceCalendar = allGPs
            
            var upcoming = [Races]()
            var past = [Races]()
            
            // Split races into upcoming and past in one pass
            for gp in allGPs {
                if let gpDate = isoDateFormatter.date(from: gp.date) {
                    if gpDate >= todayUTC {
                        upcoming.append(gp)
                    } else {
                        past.append(gp)
                    }
                }
            }
            
            raceCalendar = allGPs
            raceCalendarUpcoming = upcoming
            raceCalendarPast = past
            
            if raceCalendarPast.isEmpty{
                raceCalendarSelectedTab = 0
            }else{
                raceCalendarSelectedTab = 1
            }
            
        }catch {
            print("Failed to fetch races: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Standings View - Able to refreshData the data
    @MainActor
    func updateStandingViewYear(for year: String) async {
        standingViewYear = year
        Task {
            await refreshStandingData()
        }
    }
    
    @MainActor
    func refreshStandingData() async {
        print("Refreshing standings data for \(standingViewYear)")
        Task{
            await fetchDriverStanding()
            await fetchConstructorStanding()
        }
    }
    
    // MARK: - Fetch Driver Standing
    @MainActor
    func fetchDriverStanding() async {
        do {
            let fetchedDriverStandings = try await driverStandingsManager.fetchDriverStandings(for: standingViewYear)
            driverStanding = fetchedDriverStandings
        } catch {
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Constructor Standing
    @MainActor
    func fetchConstructorStanding() async {
        do {
            let fetchConstructorStandings = try await constructorStandingsManager.fetchConstructorStandings(for: standingViewYear)
            constructorStanding = fetchConstructorStandings
        } catch {
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - End
}


