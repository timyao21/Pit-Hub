//
//  MRData.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/19/25.
//

import Foundation

struct MRData: Codable {
    let xmlns: String
    let series: String
    let limit: String
    let offset: String
    let total: String
    let raceTable: RaceTable?
    let standingsTable: StandingsTable?
    
    enum CodingKeys: String, CodingKey {
        case xmlns
        case series
        case limit
        case offset
        case total
        case raceTable = "RaceTable"
        case standingsTable = "StandingsTable"
    }
}
// MARK: - Standings Table
struct StandingsTable: Codable {
    let season: String
    let round: String?
    let standingsLists: [StandingsList]?
    
    enum CodingKeys: String, CodingKey {
        case season, round
        case standingsLists = "StandingsLists"
    }
}

// MARK: - Standings List
struct StandingsList: Codable {
    let season: String
    let round: String
    let driverStandings: [DriverStanding]? // DriverStandings
    let constructorStandings: [ConstructorStanding]?
    
    enum CodingKeys: String, CodingKey {
        case season, round
        case driverStandings = "DriverStandings"
        case constructorStandings = "ConstructorStandings"
    }
}

