//
//  GP.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import Foundation

struct Circuit: Codable, Identifiable {
    var id: String { circuitId }
    let circuitId: String
    let circuitName: String
    let location: Location
    let url: String

    enum CodingKeys: String, CodingKey {
        case circuitId
        case circuitName
        case location = "Location"
        case url
    }
}


struct Location: Codable {
    let lat: String
    let long: String
    let locality: String
    let country: String
}


struct GP: Codable, Identifiable {
    var id = UUID()
    let raceName: String
    let circuit: Circuit
    let date: String
    let time: String?
    let firstPractice: RaceSession?
    let secondPractice: RaceSession?
    let thirdPractice: RaceSession?
    let qualifying: RaceSession?
    let sprintQualifying: RaceSession?
    let sprint: RaceSession?

    enum CodingKeys: String, CodingKey {
        case raceName
        case circuit = "Circuit"
        case date
        case time
        case firstPractice = "FirstPractice"
        case secondPractice = "SecondPractice"
        case thirdPractice = "ThirdPractice"
        case qualifying = "Qualifying"
        case sprintQualifying = "SprintQualifying"
        case sprint = "Sprint"
    }
}


struct RaceSession: Codable {
    let date: String
    let time: String?
}

struct RaceTable: Codable {
    let season: String
    let races: [GP]
    
    enum CodingKeys: String, CodingKey {
        case season
        case races = "Races"
    }
}

struct MRData: Codable {
    let raceTable: RaceTable
    
    enum CodingKeys: String, CodingKey {
        case raceTable = "RaceTable"
    }
}

struct F1ScheduleResponse: Codable {
    let mrData: MRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}
