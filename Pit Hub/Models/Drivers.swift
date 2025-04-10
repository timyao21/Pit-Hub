//
//  Drivers.swift
//  Pit Hub
//
//  Created by Junyu Yao on 4/9/25.
//

import Foundation

// MARK: - Root Response Model
struct DriversRoot: Codable {
    let mrData: MRData

    enum CodingKeys: String, CodingKey {
        case mrData = "MRData"
    }
}
