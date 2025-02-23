//
//  BottomNavBarIndexViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import Foundation


class IndexViewModel: ObservableObject, @unchecked Sendable {
    // MARK: - Data Manager
    private let driverStandingsManager = DriverStandingsManager()
    private let constructorStandingsManager = ConstructorStandingsManager()
    private let gpManager = GPManager()
    
    // MARK: - Home View Properties
    @Published var scheduleViewYear: String = String(Calendar.current.component(.year, from: Date()))
    @Published var allGP: [Races] = []
    @Published var allPastGP: [Races] = []
    @Published var allUpcomingGP: [Races] = []
    @Published var upcomingGP: Races?
    
    // MARK: - Race Calendar View Properties
    @Published var raceCalendarViewYear: String = String(Calendar.current.component(.year, from: Date()))
    @Published var raceCalendar: [Races] = []
    @Published var raceCalendarPast: [Races] = []
    @Published var raceCalendarUpcoming: [Races] = []
    
    
    // MARK: - Home Page GP Data
    
    init() {
        Task {
            await fetchAllGP() // Load data for both Homepage & Race Calendar
            await fetchDriverStanding() // Load standings data
            await fetchConstructorStanding() // Load standings data
        }
    }
    
//    Load All GP
    func fetchAllGP() async {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
        let today = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: today)
        
        
        do {
            let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
            
            // Ensure correct date conversion
            allGP = allGPs
            
            allUpcomingGP = allGPs.filter { gp in
                if let gpDate = dateFormatter.date(from: gp.date) {
                    return gpDate >= today
                }
                return false
            }
            
            allPastGP = allGPs.filter { gp in
                if let gpDate = dateFormatter.date(from: gp.date) {
                    return gpDate < today
                }
                return false
            }
            
            upcomingGP = allUpcomingGP.first
            // Update Race Calendar Data
            raceCalendar = allGP
            raceCalendarPast = allPastGP
            raceCalendarUpcoming = allUpcomingGP
            
            print("Upcoming GPs: \(allUpcomingGP.count)")
            print("Past GPs: \(allPastGP.count)")
            
        } catch {
            print("Failed to fetch races: \(error.localizedDescription)")
        }
    }
    
//    Refresh GP Data (Only Update the Upcoming GP)
    func refreshHomeGPData() {
        print("🔄 Refreshing Home Grand Prix Data...")
        
        Task {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
            let today = Date()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: today)
            
            do {
                let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
                
                // Ensure correct date conversion
                allGP = allGPs
                
                allUpcomingGP = allGPs.filter { gp in
                    if let gpDate = dateFormatter.date(from: gp.date) {
                        return gpDate >= today
                    }
                    return false
                }
                
                upcomingGP = allUpcomingGP.first
                
                print("Upcoming GPs: \(allUpcomingGP.count)")
                print("Past GPs: \(allPastGP.count)")
                
            } catch {
                print("Failed to fetch races: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Race calendar view
    
    func updateRaceCalendarViewYear(for year: String) {
        self.raceCalendarViewYear = year
        Task{
            await refreshRaceCalendarData()
        }
    }
    
    func refreshRaceCalendarData() async {
        print("Refreshing Calendar Data for \(raceCalendarViewYear)...")
        
        Task{
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
            let today = Date()
            do{
                let allGPs = try await gpManager.fetchRaceSchedule(for: raceCalendarViewYear)
                
                // Ensure correct date conversion
                DispatchQueue.main.async {
                    self.raceCalendar = allGPs
                    
                    self.raceCalendarUpcoming = allGPs.filter { gp in
                        if let gpDate = dateFormatter.date(from: gp.date) {
                            return gpDate >= today
                        }
                        return false
                    }
                    
                    self.raceCalendarPast = allGPs.filter { gp in
                        if let gpDate = dateFormatter.date(from: gp.date) {
                            return gpDate < today
                        }
                        return false
                    }
                }
            }
            catch {
                print("Failed to fetch races: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Standings View Properties
    @Published var driverStanding: [DriverStanding] = []
    @Published var constructorStanding: [ConstructorStanding] = []
    @Published var standingViewYear: String = String(Calendar.current.component(.year, from: Date()))
    
    // MARK: - Able to refreshData the data
    func updateStandingViewYear(for year: String) {
        self.standingViewYear = year
        Task {
            await refreshStandingData()
        }
    }
    
    func refreshStandingData() async {
        print("Refreshing standings data...")
        Task{
            await fetchDriverStanding()
            await fetchConstructorStanding()
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
            DispatchQueue.main.async {
                self.driverStanding = []
            }
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Constructor Standing
    func fetchConstructorStanding() async {
        do {
            let fetchConstructorStandings = try await constructorStandingsManager.fetchConstructorStandings(for: standingViewYear)
            DispatchQueue.main.async {
                self.constructorStanding = fetchConstructorStandings
            }
        } catch {
            DispatchQueue.main.async {
                self.constructorStanding = []
            }
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }
    
    
    // End
    
}


