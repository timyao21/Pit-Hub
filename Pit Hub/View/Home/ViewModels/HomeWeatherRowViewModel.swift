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
        
        // Continue with weather data loading using latDouble and longDouble.
        print("Loading weather data for latitude \(latDouble) and longitude \(longDouble)")
        
        if race?.secondPractice?.date != nil && race?.secondPractice?.time != nil{
            let date = race!.secondPractice!.date
            let time = race!.secondPractice!.time
            day1Weather = await fetchHourlyWeather(lat: latDouble, long: longDouble, date: date, time: time!, hour: 1)
        }
        
    }
    
    @MainActor
    func fetchHourlyWeather(lat: Double, long: Double, date: String, time: String, hour: Int) async -> [HourWeather]{
        let location = CLLocation(latitude: lat, longitude: long)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        // Convert UTC to local using your utility which returns a date string.
        guard let baseTimeString = DateUtilities.convertUTCToLocal(date: date, time: time, format: "yyyy-MM-dd HH:mm"),
              let baseDate = dateFormatter.date(from: baseTimeString) else {
            print("Invalid base date: \(date) \(time)")
            return []
        }
        
        var hourlyForecasts: [HourWeather] = []
        
        // Fetch hourly forecasts for the specified number of hours.
        for hourOffset in 0..<hour {
            let forecastDate = baseDate.addingTimeInterval(Double(hourOffset * 3600))
            let forecastTimeString = dateFormatter.string(from: forecastDate)
            
            if let forecast = await weatherManager.fetchHourlyWeather(for: location, on: forecastTimeString) {
                hourlyForecasts.append(forecast)
            }
        }
        print(hourlyForecasts)
        return []
    }

    
    @MainActor
    func fetchWeather() async {
        if let latString = race?.circuit.location.lat,
           let latDouble = Double(latString),
           let longString = race?.circuit.location.long,
           let longDouble = Double(longString) {
            // Use latDouble and longDouble as needed (e.g., assign to a variable or property)
            forecastDay = await weatherManager.fetchHourlyWeather(for: CLLocation(latitude: latDouble, longitude: longDouble), on: "2025-03-16 4:00")
            print("Latitude: \(latDouble), Longitude: \(longDouble)")
            print("temp - \(forecastDay?.temperature)")
        } else {
            // Handle the error appropriately (e.g., return, throw an error, etc.)
            print("Conversion from string to double failed.")
        }


//        forecastDay = await weatherManager.fetchHourlyWeather(for: CLLocation(latitude: latDouble!, longitude: longDouble!), on: "2025-03-10 5:00")
        print(forecastDay?.symbolName ?? "No weather data")
    }
    
    func fetchHourlyWeather2() async {
        guard let latString = await race?.circuit.location.lat,
              let latDouble = Double(latString),
              let longString = await race?.circuit.location.long,
              let longDouble = Double(longString) else {
            print("Conversion from string to double failed.")
            return
        }
        
        let location = CLLocation(latitude: latDouble, longitude: longDouble)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm"
        
        // Base forecast time – adjust as needed.
        guard let baseDate = dateFormatter.date(from: "2025-03-16 4:00") else {
            print("Invalid base date")
            return
        }
        
        var nextThreeHoursWeather: [HourWeather] = []
        
        // Fetch forecast for the next 3 hours, including the base time.
        for hourOffset in 0..<3 {
            let forecastDate = baseDate.addingTimeInterval(Double(hourOffset * 3600))
            let forecastTimeString = dateFormatter.string(from: forecastDate)
            
            if let forecast = await weatherManager.fetchHourlyWeather(for: location, on: forecastTimeString) {
                nextThreeHoursWeather.append(forecast)
            }
        }
        
        // Use nextThreeHoursWeather as needed.
        // For example, assign it to a property or update your UI.
        print(nextThreeHoursWeather)
    }

    
}
