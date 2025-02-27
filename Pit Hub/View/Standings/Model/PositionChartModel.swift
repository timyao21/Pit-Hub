//
//  PositionChartModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/27/25.
//

import Foundation

struct PositionChart: Codable, Identifiable{
    var id: String { "\(year)-\(driverName)-\(round)" }
    let year: String
    let driverName: String
    let driverNumber: String?
    let round: String
    let position: String
}
