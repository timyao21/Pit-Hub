//
//  DateUtils.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/9/24.
//

import Foundation

struct DateUtils {
    
    // MARK: - Convert date string to Date
//    static func toDate(dateString: String) -> String? {
//        let formatter = ISO8601DateFormatter()
//        if let date = formatter.date(from: dateString) {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = .medium
//            dateFormatter.timeStyle = .short
//            return dateFormatter.string(from: date)
//        }
//        return nil
//    }
    
    // MARK: - format the ISO8601 Data Format to local time with custom style
    static func formatLocalFullDateString(_ dateString: String, dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .none) -> String? {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = dateStyle
            dateFormatter.timeStyle = timeStyle
            dateFormatter.timeZone = .current
            dateFormatter.locale = Locale(identifier: "zh_CN")
            return dateFormatter.string(from: date)
        }
        return nil
    }
    // MARK: - format the ISO8601 Data Format to local time only month and day (Chinese)
    static func formatLocalDateString(_ dateString: String) -> String? {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "M月d日 HH:mm"// Format for month and day
            dateFormatter.dateFormat = "M月d日"// Format for month and day
            dateFormatter.timeZone = .current
            dateFormatter.locale = Locale(identifier: "zh_CN") // Change this for different locales if needed
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    // MARK: - get weekday from the ISO8601 date string (Chinese)
    static func getWeekday(from dateString: String) -> String? {
        // Step 1: Convert the ISO8601 date string to a Date object
        let isoFormatter = ISO8601DateFormatter()
        guard let date = isoFormatter.date(from: dateString) else {
            return nil
        }
        
        // Step 2: Use DateFormatter to get the weekday from the Date object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // EEEE gives the full name of the weekday (e.g., Monday)
        dateFormatter.timeZone = .current // Adopts the current device's time zone
        dateFormatter.locale = Locale(identifier: "zh_CN") // Sets the locale to Chinese
        let weekday = dateFormatter.string(from: date)
        
        return weekday
    }
    
}
