////
////  HomeWeatherRowViewModel.swift
////  Pit Hub
////
////  Created by Junyu Yao on 3/9/25.
////
//
//import Foundation
//import WeatherKit
//import CoreLocation
//
////struct HourWeatherData: Codable, Identifiable{
////    var id = UUID()
////    let temp: Double
////    let symbolName: String
////}
//
//@Observable class HomeWeatherViewModel {
//    let weatherManager = WeatherManager.shared
////    @MainActor var race: Races?
//    
//    @MainActor var showWeatherData: Bool = false
//    @MainActor var fp1Weather: HourWeather?
//    @MainActor var sprintQualiWeather: [HourWeather] = []
//    @MainActor var secondPracticeWeather: [HourWeather] = []
//    @MainActor var thirdPracticeWeather: [HourWeather] = []
//    @MainActor var sprintWeather: [HourWeather] = []
//    @MainActor var qualifyingWeather: [HourWeather] = []
//    @MainActor var raceWeather: [HourWeather] = []
//    @MainActor var fullRaceWeather: [HourWeather] = []
//    
//    @MainActor
//    func loadWeatherData(for race: Races?) async {
//        guard let latString = race?.circuit.location.lat,
//              let latDouble = Double(latString),
//              let longString = race?.circuit.location.long,
//              let longDouble = Double(longString) else {
//            print("Conversion from string to double failed.")
//            showWeatherData = false
//            return
//        }
//        
//        // get the full race weather Data
//        let location = CLLocation(latitude: latDouble, longitude: longDouble)
//        
//        if let dateString = race?.firstPractice?.date,
//           let timeString = race?.firstPractice?.time {
//            let date = getUTCTimeDate(for: dateString, time: timeString).roundedToHour()
//            
//            Task {
//                fullRaceWeather = await fetchHourlyWeather(for: location, on: date, hours: 96)
//                if let fpWeather = fullRaceWeather.first {
//                    fp1Weather = fpWeather
//                }
//                
//                if let sprintQualiDate = race?.sprintQualifying?.date,
//                   let sprintQualiTime = race?.sprintQualifying?.time {
//                    let sprintQualiFullDate = getUTCTimeDate(for: sprintQualiDate, time: sprintQualiTime).roundedToHour()
//                    sprintQualiWeather = fullRaceWeather.filter { $0.date == sprintQualiFullDate }
//                }
//                
//                if let spDate = race?.secondPractice?.date,
//                   let spTime = race?.secondPractice?.time {
//                    let spFullDate = getUTCTimeDate(for: spDate, time: spTime).roundedToHour()
//                    secondPracticeWeather = fullRaceWeather.filter { $0.date == spFullDate }
//                }
//                
//                if let tpDate = race?.thirdPractice?.date,
//                   let tpTime = race?.thirdPractice?.time {
//                    let tpFullDate = getUTCTimeDate(for: tpDate, time: tpTime).roundedToHour()
//                    thirdPracticeWeather = fullRaceWeather.filter { $0.date == tpFullDate }
//                    print(tpFullDate)
//                }
//                
//                if let sDate = race?.sprint?.date,
//                   let sTime = race?.sprint?.time {
//                    let sFullDate = getUTCTimeDate(for: sDate, time: sTime).roundedToHour()
//                    sprintWeather = fullRaceWeather.filter { $0.date == sFullDate }
//                }
//                
//                if let qualDate = race?.qualifying?.date,
//                   let qualTime = race?.qualifying?.time {
//                    let qualFullDate = getUTCTimeDate(for: qualDate, time: qualTime).roundedToHour()
//                    qualifyingWeather = fullRaceWeather.filter { $0.date == qualFullDate }
//                    print(qualifyingWeather)
//                }
//                
//                if let raceDate = race?.date, let raceTime = race?.time {
//                    var calendar = Calendar(identifier: .gregorian)
//                    calendar.timeZone = TimeZone(identifier: "UTC")!
//                    let raceFullDate = getUTCTimeDate(for: raceDate, time: raceTime).roundedToHour()
//                    if let endDate = calendar.date(byAdding: .hour, value: 4, to: raceFullDate) {
//                        raceWeather = fullRaceWeather.filter { $0.date >= raceFullDate && $0.date < endDate }
//                    }
//                }
//            }
//        }
//    }
//    
//    @MainActor
//    func fetchHourlyWeather(for location: CLLocation, on date: Date, hours: Int) async -> [HourWeather] {
//        print(date)
//
//        do {
//            let weather = try await weatherManager.service.weather(for: location)
//            
//            // Use a UTC calendar for consistent date comparisons.
//            var calendar = Calendar(identifier: .gregorian)
//            calendar.timeZone = TimeZone(identifier: "UTC")!
//            
//            // Calculate the end date: 'hours' after the given date.
//            let endDate = calendar.date(byAdding: .hour, value: hours, to: date)!
//            
//            // Filter the forecast to include hourly entries between date (inclusive) and endDate (exclusive).
//            let hourlyForecast = weather.hourlyForecast.forecast.filter { forecast in
//                forecast.date >= date && forecast.date < endDate
//            }
//            return hourlyForecast
//        } catch {
//            print("Failed to fetch hourly weather data: \(error)")
//            return []
//        }
//    }
//
//    private func getUTCTimeDate(for date: String, time: String) -> Date {
//        let dateString = "\(date) \(time)"
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
//        formatter.timeZone = TimeZone(identifier: "UTC")
//        return formatter.date(from: dateString)!
//    }
//
//}
//
////extension Date {
////    // Returns the date rounded down to the nearest whole hour in UTC.
////    func roundedToHour() -> Date {
////        var calendar = Calendar(identifier: .gregorian)
////        calendar.timeZone = TimeZone(identifier: "UTC")!
////        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
////        return calendar.date(from: components)!
////    }
////    
////}
