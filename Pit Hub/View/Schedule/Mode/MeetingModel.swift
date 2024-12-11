//
//  MeetingModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct Meeting: Codable, Identifiable {
    var id = UUID()
    let circuitKey: Int?
    let circuitShortName: String
    let countryCode: String
    let countryKey: Int
    let countryName: String
    let dateStart: String
    let gmtOffset: String
    let location: String
    let meetingKey: Int
    let meetingName: String
    let meetingOfficialName: String
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
        case meetingKey = "meeting_key"
        case meetingName = "meeting_name"
        case meetingOfficialName = "meeting_official_name"
        case year
    }
}
