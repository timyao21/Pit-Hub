//
//  GPManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import Foundation

struct GPManager {
    
    func fetchRaceSchedule(for year: String) async throws -> [GP] {
        let baseURL = "https://api.jolpi.ca/ergast/f1/\(year)/races/?format=json"
        print("Fetching race schedule for \(year)...") // Dynamic year in print
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let scheduleResponse = try decoder.decode(F1ScheduleResponse.self, from: data)
            let races = scheduleResponse.mrData.raceTable.races
            print("Successfully fetched \(races.count) races for \(year).")
            return races
        } catch {
            print("Error decoding race schedule for \(year): \(error.localizedDescription)")
            throw error
        }
    }
}
