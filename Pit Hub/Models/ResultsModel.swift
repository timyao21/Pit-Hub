//
//  ResultsModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/21/25.
//

import Foundation


// MARK: - Race Result

struct Results: Codable {
    let number: String
    let position: String
    let positionText: String
    let points: String
    let grid: String?
    let laps: String?
    let status: String?
    let time: RaceTime?
    let driver: Driver
    let constructor: Constructor?
    let fastestLap: FastestLap?  // Added fastestLap

    enum CodingKeys: String, CodingKey {
        case number, position, positionText, points, grid, laps, status
        case time = "Time"
        case driver = "Driver"
        case constructor = "Constructor"
        case fastestLap = "FastestLap"
    }
}

struct RaceTime: Codable {
    let millis: String?
    let time: String
}

struct FastestLap: Codable {
    let rank: String
    let lap: String
    let time: RaceTime?  // For FastestLap, only "time" is provided in the JSON
    let averageSpeed: AverageSpeed?

    enum CodingKeys: String, CodingKey {
        case rank, lap
        case time = "Time"
        case averageSpeed = "AverageSpeed"
    }
}

struct AverageSpeed: Codable {
    let units: String
    let speed: String
}


// MARK: - Qulifying Result

struct QualifyingResults: Codable{
    let number: String
    let position: String
    let driver: Driver
    let constructor: Constructor?
    let q1: String?
    let q2: String?
    let q3: String?
}
