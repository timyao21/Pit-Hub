//
//  MeetingModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct Driver: Codable, Identifiable {
    var id = UUID()
    let broadcastName: String
    let countryCode: String
    let driverNumber: Int
    let firstName: String
    let fullName: String
    let lastName: String
    let nameAcronym: String
    let points: Int
    let teamColour: String
    let teamName: String

    enum CodingKeys: String, CodingKey {
        case broadcastName = "broadcast_name"
        case countryCode = "country_code"
        case driverNumber = "driver_number"
        case firstName = "first_name"
        case fullName = "full_name"
        case lastName = "last_name"
        case nameAcronym = "name_acronym"
        case teamColour = "team_colour"
        case teamName = "team_name"
        case points = "points"
    }
}
