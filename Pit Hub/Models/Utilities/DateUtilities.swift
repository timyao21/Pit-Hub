//
//  DateUtilities.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/15/25.
//

import Foundation
import SwiftUICore


struct DateUtilities {
    
    static func combineDateToUtc(from dateString: String, and timeString: String) -> Date? {
        // Combine the date and time strings into a full ISO8601 string.
        // e.g., "2025-03-16" + "T" + "04:00:00Z" -> "2025-03-16T04:00:00Z"
        let combined = "\(dateString)T\(timeString)"
        
        let isoFormatter = ISO8601DateFormatter()
        return isoFormatter.date(from: combined)
    }

    
    static func localizedDateFormat(for format: String, language: String) -> String {
    
        if language == "zh" {
            switch format {
            case "yyyy-MM-dd":
                return "yyyy年MM月dd日"
            case "MM-dd":
                return "MM月dd日"
            default:
                return format
            }
        }
        return format
//        // Retrieve the stored language string and convert it to an AppLanguage.
//        let languageRaw = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
//        guard let language = AppLanguage(rawValue: languageRaw) else {
//            return format
//        }
//    
//        if language == .chinese {
//            switch format {
//            case "yyyy-MM-dd":
//                return "yyyy年MM月dd日"
//            case "MM-dd":
//                return "MM月dd日"
//            default:
//                return format
//            }
//        }
//        
//        return format
    }
    
    // Converts separate UTC date and time strings to local time zone formatted string
    // - Parameters:
    //   - date: The date string in "yyyy-MM-dd" format
    //   - time: The time string in "HH:mm:ssZ" format
    //   - format: The desired output format (default: "yyyy-MM-dd HH:mm:ss")
    // - Returns: A formatted string in the local time zone
    static func convertUTCToLocal(date: String, time: String, format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let utcDateTimeString = "\(date)T\(time)"
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let utcDate = dateFormatter.date(from: utcDateTimeString) else { return nil }
        
        let localFormatter = DateFormatter()
        localFormatter.dateFormat = format
        localFormatter.timeZone = TimeZone.current
        return localFormatter.string(from: utcDate)
    }
    
    static func convertToUTC(_ date: Date) -> Date {
        let timeZoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return date.addingTimeInterval(-timeZoneOffset) // Convert local time to UTC
    }
    
    static func convertToUTCString (date: String, time: String, format: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        let utcDateTimeString = "\(date)T\(time)"
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let utcDate = dateFormatter.date(from: utcDateTimeString) else { return nil }
        
        let localFormatter = DateFormatter()
        localFormatter.dateFormat = format
        localFormatter.timeZone = TimeZone.current
        return localFormatter.string(from: utcDate)
    }
    
}


extension Date {
    // Returns the date rounded down to the nearest whole hour in UTC.
    func roundedToHour() -> Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: self)
        return calendar.date(from: components)!
    }
    
    static var capitalizedFirstLetterOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.veryShortWeekdaySymbols
        // Reorder so that Monday ("一") becomes the first element.
        let mondayBasedWeekdays = Array(weekdays[1..<weekdays.count]) + [weekdays[0]]
        return mondayBasedWeekdays
    }
    
}
