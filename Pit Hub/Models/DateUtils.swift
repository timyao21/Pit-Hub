//
//  DateUtils.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/9/24.
//

import Foundation

struct DateUtils {
    static func getCurrentDate() -> Date {
        return Date()
    }
    
    static func formatDate(_ date: Date, dateStyle: DateFormatter.Style = .medium, timeStyle: DateFormatter.Style = .none) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: date)
    }
}
