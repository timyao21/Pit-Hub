//
//  MRData.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/19/25.
//

import Foundation

struct JolpicaF1Root: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct MRData: Codable {
    let xmlns: String
    let series: String
    let limit: String
    let offset: String
    let total: String
    let raceTable: RaceTable?
    let standingsTable: StandingsTable?
    let driverTable: DriverTable?
    
    enum CodingKeys: String, CodingKey {
        case xmlns
        case series
        case limit
        case offset
        case total
        case raceTable = "RaceTable"
        case standingsTable = "StandingsTable"
        case driverTable = "DriverTable"
    }
}

struct DriverTable: Codable {
    let season: String
    let drivers: [Driver]

    enum CodingKeys: String, CodingKey {
        case season
        case drivers = "Drivers"
    }
}

