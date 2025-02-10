//
//  GrandPrix.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/9/25.
//


import Foundation

struct GrandPrix: Identifiable, Codable {
    var id = UUID()
    let circuitKey: Int
    let circuitShortName: String
    let countryCode: String
    let countryKey: Int
    let countryName: String
    var dateStart: String
    let gmtOffset: String
    let location: String
    let meetingCode: String
    let meetingKey: Int
    let meetingName: String
    let meetingOfficialName: String
    let sprint: Bool
    let year: Int

    enum CodingKeys: String, CodingKey {
        case circuitKey = "circuit_key"
        case circuitShortName = "circuit_short_name"
        case countryCode = "country_code"
        case countryKey = "country_key"
        case countryName = "country_name"
        case dateStart = "date_start"
        case gmtOffset = "gmt_offset"
        case location
        case meetingCode = "meeting_code"
        case meetingKey = "meeting_key"
        case meetingName = "meeting_name"
        case meetingOfficialName = "meeting_official_name"
        case sprint
        case year
    }
}
