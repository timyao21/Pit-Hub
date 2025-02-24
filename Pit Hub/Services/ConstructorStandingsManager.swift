//
//  ConstructorStandingsManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/13/25.
//

import Foundation

struct ConstructorStandingsManager {
    
    func fetchConstructorStandings(for year: String) async throws -> [ConstructorStanding] {
        let baseURL = "https://api.jolpi.ca/ergast/f1/\(year)/constructorstandings/"
        
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do{
            let constructorStandingsRoot = try decoder.decode(ConstructorStandingsRoot.self, from: data)
            let constructorStandingsList = constructorStandingsRoot.mrData.standingsTable?.standingsLists.first?.constructorStandings ?? []
            
            return constructorStandingsList
            
        } catch {
            print("Error decoding constructor standings for \(year): \(error.localizedDescription)")
            throw error
        }
        
    }
}

