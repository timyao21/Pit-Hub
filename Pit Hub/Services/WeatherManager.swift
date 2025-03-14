//
//  WeatherManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/9/25.
//
// 40.724409, -74.038310
import Foundation
import WeatherKit
import CoreLocation


class WeatherManager {
    static let shared = WeatherManager()
    let service = WeatherService.shared
    
    var temperatureFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter
    }()
    
    func currentWeather(for location: CLLocation) async -> CurrentWeather? {
        print("Fetching current weather for \(location)...")
        do {
            // Call the weather API directly without a detached task
            let forecast = try await service.weather(for: location, including: .current)
            return forecast
        } catch {
            print("Error fetching weather: \(error)")
            return nil
        }
    }
    
    func fetchHourlyWeather(for location: CLLocation, on dateString: String) async -> HourWeather? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = formatter.date(from: dateString)!
        
        let weatherService = WeatherService()
        do {
            let weather = try await weatherService.weather(for: location)
            let calendar = Calendar.current
            // Compare dates using minute granularity.
            let hourWeather = weather.hourlyForecast.forecast.first { forecast in
                calendar.compare(forecast.date, to: date, toGranularity: .minute) == .orderedSame
            }
            return hourWeather
        } catch {
            print("Failed to fetch hourly weather data: \(error)")
            return nil
        }
    }

    //end
}
