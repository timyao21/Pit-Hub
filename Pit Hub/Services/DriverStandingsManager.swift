//
//  GPManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import Foundation

struct DriverStandingsManager {
    
    func fetchDriverStandings(for year: String) async throws -> [DriverStanding] {
        let baseURL = "https://api.jolpi.ca/ergast/f1/\(year)/driverStandings/?format=json"
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let driverStandingsRoot = try decoder.decode(DriverStandingsRoot.self, from: data)
            let driverStandings = driverStandingsRoot.mrData.standingsTable?.standingsLists?.first?.driverStandings ?? []
            
            return driverStandings
        } catch {
            print("Error decoding drivers standings for \(year): \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchDriverRaceResult(for year: String, driverID: String) async throws -> [Races]{
        let baseURL = "https://api.jolpi.ca/ergast/f1/\(year)/drivers/\(driverID)/results/?format=json"
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do{
            let driverResultRoot = try decoder.decode(JolpicaF1Root.self, from: data)
            let driverResult = driverResultRoot.mrData.raceTable?.races ?? []
            
            print("Successfully fetched \(driverResult.count) drivers result for \(driverID) - \(year). ------------- ")
            return driverResult
        } catch{
            print("Error decoding \(driverID) result for \(year): \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchDrivers(for year: String) async throws -> [Driver]{
        let baseURL = "https://api.jolpi.ca/ergast/f1/\(year)/drivers/?format=json"
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do{
            let driverResultRoot = try decoder.decode(DriversRoot.self, from: data)
            let driverResult = driverResultRoot.mrData.driverTable?.drivers ?? []
            
            print("Successfully fetched \(driverResult.count) ")
            return driverResult
        } catch{
            print("Error decoding Drivers")
            throw error
        }
    }

    
}
