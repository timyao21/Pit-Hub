//
//  positionColor.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/24/25.
//

import SwiftUI

struct PositionColor {
    let position: String
    
    var color: Color {
        switch position {
        case "1":
            return .orange
        case "2":
            return .gray
        case "3":
            return .brown
        default:
            return Color.primary.opacity(0.8)
        }
    }
}
