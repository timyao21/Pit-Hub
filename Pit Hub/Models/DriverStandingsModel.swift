//
//  DriverStandingsModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/12/25.
//

import Foundation

// MARK: - Root Response Model
struct DriverStandingsRoot: Codable {
    let mrData: MRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
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

// MARK: - Constructor
struct Constructor: Codable {
    let constructorId: String?
    let url: String?
    let name: String
    let nationality: String?
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

