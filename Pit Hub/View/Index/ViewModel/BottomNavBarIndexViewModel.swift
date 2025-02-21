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
    private let gpManager = GPManager()
    
    // MARK: - Home View Properties
    @Published var scheduleViewYear: String = String(Calendar.current.component(.year, from: Date()))
    @Published var allGP: [GP] = []
    @Published var allPastGP: [GP] = []
    @Published var allUpcomingGP: [GP] = []
    @Published var upcomingGP: GP?
    
    // MARK: - Race Calendar View Properties
    @Published var raceCalendarViewYear: String = String(Calendar.current.component(.year, from: Date()))
    @Published var raceCalendar: [GP] = []
    @Published var raceCalendarPast: [GP] = []
    @Published var raceCalendarUpcoming: [GP] = []
    
    // MARK: - Home Page GP Data
    func initAllGP() {
        Task {
            await fetchAllGP() // Load data for both Homepage & Race Calendar
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
    
//    Refresh GP Data
    func refreshHomeGPData() {
        print("🔄 Refreshing Grand Prix Data...")

        // Reset data before fetching new information
        allGP.removeAll()
        allUpcomingGP.removeAll()
        allPastGP.removeAll()
        upcomingGP = nil

        Task {
            await fetchAllGP() // Wait for fetch to complete
            
            // Ensure the data has been updated before accessing it
            if !allUpcomingGP.isEmpty {
                upcomingGP = allUpcomingGP.first
            } else {
                print("No upcoming Grand Prix events found.")
            }
        }
        
    }
    
    // MARK: - Race calendar view
    

    
    func updateRaceCalendarViewYear(for year: String) {
        self.raceCalendarViewYear = year
//        Task {
//            await refreshStandingData()
//        }
    }
    
    func refreshRaceCalendarData(for year: String) async {
        print("Refreshing Data for \(year)...")
    }
    
    
    
    
    

    
    // MARK: - Standings View Properties
    @Published var driverStanding: [DriverStanding] = []
    @Published var constructorStanding: [ConstructorStanding] = []
    @Published var standingViewYear: String = String(Calendar.current.component(.year, from: Date()))
    
    // MARK: - Load Standings Data
    func loadStandingsData() {
        Task {
            await fetchDriverStanding()
            await fetchConstructorStanding()
        }
    }
    // MARK: - Able to refreshData the data
    func refreshStandingData() async {
        print("Refreshing standings data...")
        await fetchDriverStanding()
        await fetchConstructorStanding()
    }
    
    func updateStandingViewYear(for year: String) {
        self.standingViewYear = year
        Task {
            await refreshStandingData()
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


