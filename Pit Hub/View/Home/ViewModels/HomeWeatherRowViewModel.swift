//
//  HomeWeatherRowViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/9/25.
//

import Foundation
import WeatherKit
import CoreLocation

@Observable class HomeWeatherRowViewModel {
    let weatherManager = WeatherManager.shared
    
    @MainActor var race: Races?
    @MainActor var currentWeather: CurrentWeather?
    @MainActor var forecastDay: HourWeather?
    
    @MainActor
    func fetchWeather() async {
//        currentWeather = await weatherManager.currentWeather(for: CLLocation(latitude: 40.724409, longitude: -74.038310))
//        var location = CLLocation(latitude: race?.circuit.location.lat, longitude: race?.circuit.location.long)
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
        print(forecastDay?.temperature ?? "No weather data")
    }
}
