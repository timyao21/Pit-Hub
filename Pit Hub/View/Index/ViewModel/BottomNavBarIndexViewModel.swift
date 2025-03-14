//
//  BottomNavBarIndexViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/14/25.
//

import Foundation
import WeatherKit
import CoreLocation

@Observable class IndexViewModel{
    // MARK: - Data Manager
    private let driverStandingsManager = DriverStandingsManager()
    private let constructorStandingsManager = ConstructorStandingsManager()
    private let gpManager = GPManager()
    let weatherManager = WeatherManager.shared
    
    // MARK: - Home View Properties
    @MainActor var allGP: [Races] = []
    @MainActor var allPastGP: [Races] = []
    @MainActor var allUpcomingGP: [Races] = []
    @MainActor var upcomingGP: Races?
    
    // Weather
    @MainActor var showWeatherData: Bool = false
    @MainActor var fp1Weather: HourWeather?
    @MainActor var sprintQualiWeather: [HourWeather] = []
    @MainActor var secondPracticeWeather: [HourWeather] = []
    @MainActor var thirdPracticeWeather: [HourWeather] = []
    @MainActor var sprintWeather: [HourWeather] = []
    @MainActor var qualifyingWeather: [HourWeather] = []
    @MainActor var raceWeather: [HourWeather] = []
    @MainActor var fullRaceWeather: [HourWeather] = []
    
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
            
            if let upcomingRace = upcomingGP,
               let gpDate = isoDateFormatter.date(from: upcomingRace.date) {
                let sevenDaysFromToday = Calendar.current.date(byAdding: .day, value: 7, to: todayUTC)!
                if gpDate <= sevenDaysFromToday {
                    await loadWeatherData(for: upcomingRace)
                }
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
            
            if let upcomingRace = upcomingGP,
               let gpDate = isoDateFormatter.date(from: upcomingRace.date) {
                let sevenDaysFromToday = Calendar.current.date(byAdding: .day, value: 7, to: todayUTC)!
                if gpDate <= sevenDaysFromToday {
                    await loadWeatherData(for: upcomingRace)
                }
            }

            
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
    
    // MARK: - Load Weather Data
    @MainActor
    func loadWeatherData(for race: Races?) async {
        guard let latString = race?.circuit.location.lat,
              let latDouble = Double(latString),
              let longString = race?.circuit.location.long,
              let longDouble = Double(longString) else {
            print("Conversion from string to double failed.")
            showWeatherData = false
            return
        }
        
        // get the full race weather Data
        let location = CLLocation(latitude: latDouble, longitude: longDouble)
        
        if let dateString = race?.firstPractice?.date,
           let timeString = race?.firstPractice?.time {
            let date = getUTCTimeDate(for: dateString, time: timeString).roundedToHour()
            
            Task {
                fullRaceWeather = await fetchHourlyWeather(for: location, on: date, hours: 96)
                if let fpWeather = fullRaceWeather.first {
                    fp1Weather = fpWeather
                }
                
                if let sprintQualiDate = race?.sprintQualifying?.date,
                   let sprintQualiTime = race?.sprintQualifying?.time {
                    let sprintQualiFullDate = getUTCTimeDate(for: sprintQualiDate, time: sprintQualiTime).roundedToHour()
                    sprintQualiWeather = fullRaceWeather.filter { $0.date == sprintQualiFullDate }
                }
                
                if let spDate = race?.secondPractice?.date,
                   let spTime = race?.secondPractice?.time {
                    let spFullDate = getUTCTimeDate(for: spDate, time: spTime).roundedToHour()
                    secondPracticeWeather = fullRaceWeather.filter { $0.date == spFullDate }
                }
                
                if let tpDate = race?.thirdPractice?.date,
                   let tpTime = race?.thirdPractice?.time {
                    let tpFullDate = getUTCTimeDate(for: tpDate, time: tpTime).roundedToHour()
                    thirdPracticeWeather = fullRaceWeather.filter { $0.date == tpFullDate }
                    print(tpFullDate)
                }
                
                if let sDate = race?.sprint?.date,
                   let sTime = race?.sprint?.time {
                    let sFullDate = getUTCTimeDate(for: sDate, time: sTime).roundedToHour()
                    sprintWeather = fullRaceWeather.filter { $0.date == sFullDate }
                }
                
                if let qualDate = race?.qualifying?.date,
                   let qualTime = race?.qualifying?.time {
                    let qualFullDate = getUTCTimeDate(for: qualDate, time: qualTime).roundedToHour()
                    qualifyingWeather = fullRaceWeather.filter { $0.date == qualFullDate }
                    print(qualifyingWeather)
                }
                
                if let raceDate = race?.date, let raceTime = race?.time {
                    var calendar = Calendar(identifier: .gregorian)
                    calendar.timeZone = TimeZone(identifier: "UTC")!
                    let raceFullDate = getUTCTimeDate(for: raceDate, time: raceTime).roundedToHour()
                    if let endDate = calendar.date(byAdding: .hour, value: 4, to: raceFullDate) {
                        raceWeather = fullRaceWeather.filter { $0.date >= raceFullDate && $0.date < endDate }
                    }
                }
            }
        }
    }
    
    @MainActor
    func fetchHourlyWeather(for location: CLLocation, on date: Date, hours: Int) async -> [HourWeather] {
        print(date)

        do {
            let weather = try await weatherManager.service.weather(for: location)
            
            // Use a UTC calendar for consistent date comparisons.
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(identifier: "UTC")!
            
            // Calculate the end date: 'hours' after the given date.
            let endDate = calendar.date(byAdding: .hour, value: hours, to: date)!
            
            // Filter the forecast to include hourly entries between date (inclusive) and endDate (exclusive).
            let hourlyForecast = weather.hourlyForecast.forecast.filter { forecast in
                forecast.date >= date && forecast.date < endDate
            }
            return hourlyForecast
        } catch {
            print("Failed to fetch hourly weather data: \(error)")
            return []
        }
    }

    private func getUTCTimeDate(for date: String, time: String) -> Date {
        let dateString = "\(date) \(time)"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.date(from: dateString)!
    }
    
    
    // MARK: - End
}
