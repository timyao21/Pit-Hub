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
        print("Fetching driver standings for \(year)...")
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let driverStandingsRoot = try decoder.decode(DriverStandingsRoot.self, from: data)
            let driverStandings = driverStandingsRoot.mrData.standingsTable.standingsLists.first?.driverStandings ?? []
            
            print("Successfully fetched \(driverStandings.count) drivers standings for \(year). ------------- ")
            return driverStandings
        } catch {
            print("Error decoding drivers standings for \(year): \(error.localizedDescription)")
            throw error
        }
    }
}
