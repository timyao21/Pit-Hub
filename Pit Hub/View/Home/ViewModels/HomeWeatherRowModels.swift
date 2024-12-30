//
//  HomeWeatherRowModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/29/24.
//

import Foundation
import WeatherKit
import CoreLocation

extension HomeWeatherRow {
    class ViewModel: ObservableObject{
        @Published var weather: Weather?
        
        private let weatherService = WeatherService.shared
        
        func fetchWeather(for city: String) -> Void{
            Task {
                 do {
                     // Convert city name to location
                     let geocoder = CLGeocoder()
                     let placemarks = try await geocoder.geocodeAddressString(city)
                     //get the location base on the name
                     guard let location = placemarks.first?.location else {
                         print("No valid location found for city: \(city)")
                         return
                     }
                     // Fetch weather data for the location
//                     let weatherData = try await weatherService.weather(for: location)
//                     DispatchQueue.main.async {
//                         self.weather = weatherData
//                     }

                 } catch {
                     print("Error fetching weather: \(error)")
                 }
             }
        }
        
        
    }
}
