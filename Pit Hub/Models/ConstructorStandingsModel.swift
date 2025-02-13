
//
//  ConstructorStandingsModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/12/25.
//

import Foundation

// MARK: - Root Response Model
struct ConstructorStandingsRoot: Codable {
    let mrData: ConstructorStandingsResponse

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

// MARK: - Main Response Model
struct ConstructorStandingsResponse: Codable {
    let series: String
    let url: String
    let limit: String
    let offset: String
    let total: String
    let standingsTable: ConstructorStandingsTable

    enum CodingKeys: String, CodingKey {
        case series, url, limit, offset, total
        case standingsTable = "StandingsTable"
    }
}

// MARK: - Constructor Standings Table
struct ConstructorStandingsTable: Codable {
    let season: String
    let round: String
    let standingsLists: [ConstructorStandingsList]

    enum CodingKeys: String, CodingKey {
        case season, round
        case standingsLists = "StandingsLists"
    }
}

// MARK: - Constructor Standings List
struct ConstructorStandingsList: Codable {
    let season: String
    let round: String
    let constructorStandings: [ConstructorStanding]

    enum CodingKeys: String, CodingKey {
        case season, round
        case constructorStandings = "ConstructorStandings"
    }
}

// MARK: - Constructor Standing
struct ConstructorStanding: Codable {
    let position: String?
    let positionText: String
    let points: String
    let wins: String
    let constructor: ConstructorTeam

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case constructor = "Constructor"
    }
}

// MARK: - Constructor Team
struct ConstructorTeam: Codable {
    let constructorId: String
    let url: String
    let name: String
    let nationality: String
}

