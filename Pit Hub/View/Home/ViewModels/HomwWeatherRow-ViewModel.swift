//
//  HomwWeatherRow-ViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 5/4/25.
//

import Foundation
import WeatherKit
import CoreLocation

extension HomeWeatherRow {
    
    @Observable class ViewModel{
        let weatherManager = WeatherManager.shared
        
        // Weather
        @MainActor var fp1Weather: [HourWeather] = []
        @MainActor var sprintQualiWeather: [HourWeather] = []
        @MainActor var fp2Weather: [HourWeather] = []
        @MainActor var fp3Weather: [HourWeather] = []
        @MainActor var sprintWeather: [HourWeather] = []
        @MainActor var qualifyingWeather: [HourWeather] = []
        @MainActor var raceWeather: [HourWeather] = []
        @MainActor var fullRaceWeather: [HourWeather] = []
        
        // MARK: - Computed Property for DateFormatter
        private var isoDateFormatter: ISO8601DateFormatter {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate]
            return formatter
        }
        
        init(race: Races) {
            let today = Date()
            
            Task {
                if let raceDate = isoDateFormatter.date(from: race.date){
                    // Check if within 10 day of the race
                    let fourteenDaysFromToday = Calendar.current.date(byAdding: .day, value: 10, to: today)!
                    if raceDate <= fourteenDaysFromToday {
                        await refreshWeather(for: race)
                    }
                }
            }
            print("Weather Loaded")
        }
        
        @MainActor
        func refreshWeather(for race: Races?) async{
            // Convert the lat and long to CLLocation
            guard let latString = race?.circuit.location.lat,
                  let latDouble = Double(latString),
                  let longString = race?.circuit.location.long,
                  let longDouble = Double(longString),
                  let date = race?.firstPractice?.date,
                  let time = race?.firstPractice?.time
            else {
                print("Failed to parse circuit coordinates or FP1 time")
                return
            }
            
            let location = CLLocation(latitude: latDouble, longitude: longDouble)
            
            guard let fp1Time = DateUtilities.combineDate(from: date, and: time)?.roundedToHour()
            else{
                return
            }
            
            fullRaceWeather = await fetchHourlyWeather(for: location, on: fp1Time, hours: 96)
            
            func weather(for date: String?, time: String?) -> [HourWeather] {
                guard let d = date, let t = time else { return [] }
                let target = DateUtilities.combineDate(from: d, and: t)?.roundedToHour()
                return fullRaceWeather.filter { $0.date == target }
            }
            
            fp1Weather = weather(for: race?.firstPractice?.date,  time: race?.firstPractice?.time)
            sprintQualiWeather = weather(for: race?.sprintQualifying?.date, time: race?.sprintQualifying?.time)
            fp2Weather  = weather(for: race?.secondPractice?.date,  time: race?.secondPractice?.time)
            fp3Weather   = weather(for: race?.thirdPractice?.date,   time: race?.thirdPractice?.time)
            sprintWeather  = weather(for: race?.sprint?.date,          time: race?.sprint?.time)
            qualifyingWeather  = weather(for: race?.qualifying?.date,      time: race?.qualifying?.time)
            
            if let rDate = race?.date, let rTime = race?.time {
                guard let start = DateUtilities.combineDate(from: rDate, and: rTime)?.roundedToHour() else { return }
                if let end = Calendar(identifier: .gregorian).date(byAdding: .hour, value: 4, to: start) {
                    raceWeather = fullRaceWeather.filter { $0.date >= start && $0.date < end }
                }
            }
        }
        
        
        func fetchHourlyWeather(for location: CLLocation, on date: Date, hours: Int) async -> [HourWeather] {

            do {
                let weather = try await weatherManager.service.weather(for: location)
                
                // Use a UTC calendar for consistent date comparisons.
                let calendar = Calendar(identifier: .gregorian)
                
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
        
    }
    
}
