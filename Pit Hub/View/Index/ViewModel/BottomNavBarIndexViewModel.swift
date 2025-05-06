//
//  BottomNavBarIndexViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import Foundation
import CoreLocation
import StoreKit

@Observable class IndexViewModel{
    // MARK: - Data Manager
    private let gpManager = GPManager()
    let storeManager = StoreManager()
    
//    Data Loading view
    @MainActor var isLoading: Bool = true
    
    // MARK: - Check Membership
    @MainActor var membership: Bool = false
    @MainActor var subscriptionSheetIsPresented: Bool = false
    
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
            self.isLoading = true
            await membership = storeManager.checkMember()
            await fetchAllGP() // Load data for both Homepage & Race Calendar
            self.isLoading = false
        }
    }
    
    // MARK: - Load all the GP info (When lunch the app)
    @MainActor
    func fetchAllGP() async {
        let today = Date()
        let currentYear = Calendar.current.component(.year, from: today)
        
        do {
            let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
            allGP = allGPs
            
            var upcoming = [Races]()
            var past = [Races]()
            
            
            
            // Split races into upcoming and past in one pass
            for gp in allGPs {
                if let gpDate = DateUtilities.combineDate(from: gp.date, and: gp.time ?? " ") {
                    if gpDate >= today {
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
        await membership = storeManager.checkMember()
        
        let today = Date()
        let currentYear = Calendar.current.component(.year, from: today)
        
        do {
            let allGPs = try await gpManager.fetchRaceSchedule(for: "\(currentYear)")
            allGP = allGPs
            
            var upcoming = [Races]()
            for gp in allGPs {
                if let gpDate = DateUtilities.combineDate(from: gp.date, and: gp.time ?? " "), gpDate >= today {
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
        
        do{
            let allGPs = try await gpManager.fetchRaceSchedule(for: raceCalendarViewYear)
            raceCalendar = allGPs
            
            var upcoming = [Races]()
            var past = [Races]()
            
            // Split races into upcoming and past in one pass
            for gp in allGPs {
                if let gpDate = DateUtilities.combineDate(from: gp.date, and: gp.time ?? " ") {
                    if gpDate >= today {
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
    
    // MARK: - End
}
