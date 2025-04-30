//
//  StandingsModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/30/25.
//

import Foundation

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

// MARK: - Driver Standing
struct DriverStanding: Codable {
    let position: String?
    let positionText: String?
    let points: String
    let wins: String
    let driver: Driver
    let constructors: [Constructor]
    
    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case driver = "Driver"
        case constructors = "Constructors"
    }
}

extension DriverStanding {
    static let sample = DriverStanding(
        position: "1",
        positionText: "1",
        points: "350",
        wins: "10",
        driver: Driver(
            driverId: "hamilton",
            permanentNumber: "44",
            code: "HAM",
            url: "http://en.wikipedia.org/wiki/Lewis_Hamilton",
            givenName: "Lewis",
            familyName: "Hamilton",
            dateOfBirth: "1985-01-07",
            nationality: "British"
        ),
        constructors: [
            Constructor(
                constructorId: "mercedes",
                url: "http://en.wikipedia.org/wiki/Mercedes-Benz_in_Formula_One",
                name: "Mercedes",
                nationality: "German"
            )
        ]
    )
}

// MARK: - Driver
struct Driver: Codable, Identifiable {
    var id: String { driverId }
    let driverId: String
    let permanentNumber: String?
    let code: String?
    let url: String?
    let givenName: String
    let familyName: String
    let dateOfBirth: String?
    let nationality: String?
    
    enum CodingKeys: String, CodingKey {
        case driverId, permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
    }
}

// MARK: - Constructor Standing
struct ConstructorStanding: Codable {
    let position: String?
    let positionText: String
    let points: String
    let wins: String
    let constructor: Constructor

    enum CodingKeys: String, CodingKey {
        case position, positionText, points, wins
        case constructor = "Constructor"
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    let constructorId: String?
    let url: String?
    let name: String
    let nationality: String?
}
