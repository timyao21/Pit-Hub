//
//  F1DriverModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct F1Driver: Codable, Identifiable {
    var id: String // Unique ID: season + driver code (e.g., "2024_ALB")
    let season: Int
    let nameAcronym: String
    let fullName: String
    let lastName: String
    let firstName: String
    let broadcastName: String
    let teamName: String
    let driverNumber: Int
    let teamColour: String
    let countryCode: String
    let raceStats: RaceStats
    let championshipPosition: Int
    let tieBreaker: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case season
        case nameAcronym = "name_acronym"
        case fullName = "full_name"
        case lastName = "last_name"
        case firstName = "first_name"
        case broadcastName = "broadcast_name"
        case teamName = "team_name"
        case driverNumber = "number"
        case teamColour = "team_colour"
        case countryCode = "country_code"
        case raceStats = "race_stats"
        case championshipPosition = "championship_position"
        case tieBreaker = "tie_breaker"
    }
}

struct RaceStats: Codable {
    let points: Int
    let wins: Int
    let podiums: Int
    let poles: Int
    let fastestLaps: Int
    let dnf: Int
    let dns: Int
    let dq: Int
    

    enum CodingKeys: String, CodingKey {
        case points
        case wins
        case podiums
        case poles
        case dnf
        case dns
        case dq
        case fastestLaps = "fastest_laps"
    }
}
