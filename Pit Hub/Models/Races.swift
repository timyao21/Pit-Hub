//
//  GP.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/11/25.
//

import Foundation

struct F1RaceResponse: Codable {
    let mrData: MRData
    
    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}

struct RaceTable: Codable {
    let season: String
    let round: String?
    let races: [Races]
    
    enum CodingKeys: String, CodingKey {
        case season
        case round
        case races = "Races"
    }
}

struct Races: Codable, Identifiable {
    var id = UUID()
    let season: String
    let round: String
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
    let results: [Results]?
    let qualifyingResults : [QualifyingResults]?
    let sprintResults : [SprintResults]?
    //    let sprintQualifyingResults : [SprintQualifyingResults]?

    enum CodingKeys: String, CodingKey {
        case season
        case round
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
        case results = "Results"
        case qualifyingResults = "QualifyingResults"
        case sprintResults = "SprintResults"
    }
}

struct Circuit: Codable, Identifiable {
    var id: String { circuitId }
    let circuitId: String
    let circuitName: String
    let location: Location
    let url: String?

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



struct RaceSession: Codable {
    let date: String
    let time: String?
}


extension Races {
    static let sample = Races(
        season: "2024",
        round: "1",
        raceName: "Bahrain Grand Prix",
        circuit: Circuit(
            circuitId: "bahrain",
            circuitName: "Bahrain International Circuit",
            location: Location(
                lat: "26.0325",
                long: "50.5106",
                locality: "Sakhir",
                country: "Bahrain"
            ),
            url: "https://en.wikipedia.org/wiki/Bahrain_International_Circuit"
        ),
        date: "2024-03-02",
        time: "15:00:00Z",
        firstPractice: nil,
        secondPractice: nil,
        thirdPractice: nil,
        qualifying: nil,
        sprintQualifying: nil,
        sprint: nil,
        results: nil,
        qualifyingResults: nil,
        sprintResults: nil
    )
}

