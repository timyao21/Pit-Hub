//
//  HomeWeatherRowViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/9/25.
//

import Foundation
import WeatherKit
import CoreLocation

//struct HourWeatherData: Codable, Identifiable{
//    var id = UUID()
//    let temp: Double
//    let symbolName: String
//}

@Observable class HomeWeatherRowViewModel {
    let weatherManager = WeatherManager.shared
    
    @MainActor var race: Races?
    @MainActor var currentWeather: CurrentWeather?
    @MainActor var forecastDay: HourWeather?
    
    @MainActor var showWeatherData: Bool = false
    @MainActor var day1Weather: [HourWeather] = []
    @MainActor var day2Weather: [HourWeather] = []
    @MainActor var day3Weather: [HourWeather] = []
    
    @MainActor
    func loadWeatherData() async {
        guard let latString = race?.circuit.location.lat,
              let latDouble = Double(latString),
              let longString = race?.circuit.location.long,
              let longDouble = Double(longString) else {
            print("Conversion from string to double failed.")
            showWeatherData = false
            return
        }
        
        let location = CLLocation(latitude: latDouble, longitude: longDouble)
        
        if race?.secondPractice?.date != nil && race?.secondPractice?.time != nil{            
            let dateString = "\(race!.secondPractice!.date) \(race!.secondPractice!.time!)"
            Task{
                day1Weather = await fetchHourlyWeather(for: location, on: dateString, hours: 1)
            }
            
        }
        
    }
    
    @MainActor
    func fetchHourlyWeather(for location: CLLocation, on dateString: String, hours: Int) async -> [HourWeather]{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        // Set the formatter's time zone to UTC. The "Z" in the input indicates UTC.
        formatter.timeZone = TimeZone(identifier: "UTC")
        let startDate = formatter.date(from: dateString)!
        print(startDate)

        do {
            let weather = try await weatherManager.service.weather(for: location)
            
            // Use a UTC calendar for consistent date comparisons.
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(identifier: "UTC")!
            
            // Calculate the end date: 3 hours after the start date.
            let endDate = calendar.date(byAdding: .hour, value: hours, to: startDate)!
            
            // Filter the forecast to include hourly entries between startDate (inclusive) and endDate (exclusive).
            let hourlyForecast = weather.hourlyForecast.forecast.filter { forecast in
                forecast.date >= startDate && forecast.date < endDate
            }
            print("------")
            print("Hourly forecast:", hourlyForecast)
            return hourlyForecast
        } catch {
            print("Failed to fetch hourly weather data: \(error)")
            return []
        }
    }
    
    
//    @MainActor
//    func fetchHourlyWeather(lat: Double, long: Double, date: String, time: String, hour: Int) async -> [HourWeather]{
//        let location = CLLocation(latitude: lat, longitude: long)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        
//        // Convert UTC to local using your utility which returns a date string.
//        guard let baseTimeString = DateUtilities.convertUTCToLocal(date: date, time: time, format: "yyyy-MM-dd HH:mm"),
//              let baseDate = dateFormatter.date(from: baseTimeString) else {
//            print("Invalid base date: \(date) \(time)")
//            return []
//        }
//        
//        var hourlyForecasts: [HourWeather] = []
//        
//        // Fetch hourly forecasts for the specified number of hours.
//        for hourOffset in 0..<hour {
//            let forecastDate = baseDate.addingTimeInterval(Double(hourOffset * 3600))
//            let forecastTimeString = dateFormatter.string(from: forecastDate)
//            
//            if let forecast = await weatherManager.fetchHourlyWeather(for: location, on: forecastTimeString) {
//                hourlyForecasts.append(forecast)
//            }
//        }
//        print(hourlyForecasts)
//        return []
//    }

    
//    @MainActor
//    func fetchWeather() async {
//        if let latString = race?.circuit.location.lat,
//           let latDouble = Double(latString),
//           let longString = race?.circuit.location.long,
//           let longDouble = Double(longString) {
//            // Use latDouble and longDouble as needed (e.g., assign to a variable or property)
//            forecastDay = await weatherManager.fetchHourlyWeather(for: CLLocation(latitude: latDouble, longitude: longDouble), on: "2025-03-16 4:00")
//            print("Latitude: \(latDouble), Longitude: \(longDouble)")
//            print("temp - \(forecastDay?.temperature)")
//        } else {
//            // Handle the error appropriately (e.g., return, throw an error, etc.)
//            print("Conversion from string to double failed.")
//        }
//
//
////        forecastDay = await weatherManager.fetchHourlyWeather(for: CLLocation(latitude: latDouble!, longitude: longDouble!), on: "2025-03-10 5:00")
//        print(forecastDay?.symbolName ?? "No weather data")
//    }
    
//    func fetchHourlyWeather(for location: CLLocation, on dateString: String) async -> HourWeather? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        // Set the formatter's time zone to UTC since the dateString is in UTC.
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
//        let date = formatter.date(from: dateString)!
//        
//        print(date)
//
////        do {
////            let weather = try await weatherService.weather(for: location)
////            
////            // Use a UTC calendar for date comparisons.
////            var calendar = Calendar(identifier: .gregorian)
////            calendar.timeZone = TimeZone(abbreviation: "UTC")!
////            
////            // Find the hourly forecast entry that exactly matches the given date (minute granularity).
////            let hourWeather = weather.hourlyForecast.forecast.first { forecast in
////                calendar.compare(forecast.date, to: date, toGranularity: .minute) == .orderedSame
////            }
////            print("hourWeather!")
////            return hourWeather
////        } catch {
////            print("Failed to fetch hourly weather data: \(error)")
////            return nil
////        }
//        return nil
//    }

    
}
