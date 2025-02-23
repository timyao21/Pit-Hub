//
//  GPManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import Foundation

struct GPManager {
    
    func fetchRaceSchedule(for year: String) async throws -> [Races] {
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
            let races = scheduleResponse.mrData.raceTable?.races ?? []
            print("Successfully fetched \(races.count) races for \(year). ------------- ")
            return races
        } catch {
            print("Error decoding race schedule for \(year): \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchRaceResults(for year: String, round: String) async throws -> [Results] {
        let baseURL = "https://api.jolpi.ca/ergast/f1/\(year)/\(round)/results/?format=json"
        print("Fetching Race Results for \(year) Round \(round)...") // Dynamic year and round in print
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let resultsResponse = try decoder.decode(F1ScheduleResponse.self, from: data)
            let results = resultsResponse.mrData.raceTable?.races.first?.results ?? []
            print("Successfully fetched \(results.count) results for \(year) Round \(round). ------------- ")
            return results
        } catch {
            print("Error decoding race results for \(year) Round \(round): \(error.localizedDescription)")
            throw error
        }
    }
    
}
