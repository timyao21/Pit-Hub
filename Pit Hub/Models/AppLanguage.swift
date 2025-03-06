//
//  AppLanguage.swift
//  Pit Hub
//
//  Created by Junyu Yao on 3/4/25.
//

import Foundation


enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "English"
    case chinese = "zh"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .english:
            return "Box!Box!"
        case .chinese:
            return "进站！进站！"
        }
    }
    
    var localeIdentifier: String {
        switch self {
        case .english:
            return "en"
        case .chinese:
            return "zh"
        }
    }
}
