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
    @Published var gps: [GP] = []
    @Published var allUpcomingGP: [GP] = []
    @Published var upcomingGP: GP?
    @Published var pastGP: [GP] = []
    
    // MARK: - Refresh GP Data
    func LoadAllGPData() {
        print("🔄 Refreshing Grand Prix Data...")

        // Reload data
        Task{
            await fetchAllGP()
        }
    }
    // MARK: - Refresh GP Data
    func refreshGPData() {
        print("🔄 Refreshing Grand Prix Data...")

        // Reset data before fetching new information
        gps.removeAll()
        allUpcomingGP.removeAll()
        pastGP.removeAll()
        upcomingGP = nil

        // Reload data
        Task{
            await fetchAllGP()
        }
    }
    
    // MARK: - Load All GP
    
    func fetchAllGP() async {
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
    func refreshData() async {
        print("Refreshing standings data...")
        await fetchDriverStanding()
        await fetchConstructorStanding()
    }
    
    // MARK: - Change the Calendar Year
    func updateStandingViewYear(for year: String) {
        self.standingViewYear = year
        Task {
            await refreshData()
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
            let constructorStandingList = try await constructorStandingsManager.fetchConstructorStandings(for: standingViewYear)
            DispatchQueue.main.async {
                self.constructorStanding = constructorStandingList.first?.constructorStandings ?? []
            }
        } catch {
            DispatchQueue.main.async {
                self.constructorStanding = []
            }
            print("Failed to fetch driver standings: \(error.localizedDescription)")
        }
    }    
    // MARK: - End
    
}


