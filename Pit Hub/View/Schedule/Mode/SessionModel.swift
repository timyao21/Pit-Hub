//
//  SessionModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/15/24.
//

import Foundation

struct Session: Codable, Identifiable {
    var id = UUID()
    let circuitKey: Int
    let circuitShortName: String
    let countryCode: String
    let countryKey: Int
    let countryName: String
    let dateEnd: String
    let dateStart: String
    let gmtOffset: String
    let location: String
    let meetingKey: Int
    let sessionKey: Int
    let sessionName: String
    let sessionType: String
    let year: Int

    enum CodingKeys: String, CodingKey {
        case circuitKey = "circuit_key"
        case circuitShortName = "circuit_short_name"
        case countryCode = "country_code"
        case countryKey = "country_key"
        case countryName = "country_name"
        case dateEnd = "date_end"
        case dateStart = "date_start"
        case gmtOffset = "gmt_offset"
        case location
        case meetingKey = "meeting_key"
        case sessionKey = "session_key"
        case sessionName = "session_name"
        case sessionType = "session_type"
        case year
    }
}
