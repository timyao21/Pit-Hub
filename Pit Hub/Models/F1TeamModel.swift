//
//  F1TeamModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct F1Team: Identifiable, Codable {
    let id: String
    let teamName: String
    let shortName: String
    let base: String
    let teamPrincipal: String
    let carModel: String
    let engineSupplier: String
    let teamColour: String
    let year: Int
    let points: Int
    let drivers: [String]

    enum CodingKeys: String, CodingKey {
        case id = "team_id"
        case teamName = "team_name"
        case shortName = "short_name"
        case base
        case teamPrincipal = "team_principal"
        case carModel = "car_model"
        case engineSupplier = "engine_supplier"
        case teamColour = "team_colour"
        case year
        case points
        case drivers
    }
}

