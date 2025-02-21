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
struct Driver: Codable {
    let driverId: String
    let permanentNumber: String?
    let code: String?
    let url: String
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
    
    enum CodingKeys: String, CodingKey {
        case driverId, permanentNumber, code, url, givenName, familyName, dateOfBirth, nationality
    }
}

// MARK: - Constructor
struct Constructor: Codable {
    let constructorId: String
    let url: String
    let name: String
    let nationality: String
}
