//
//  DateUtilities.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/15/25.
//

import Foundation


struct DateUtilities {
    
    static func localizedDateFormat(for format: String) -> String {
        // Retrieve the stored language string and convert it to an AppLanguage.
        let languageRaw = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
        guard let language = AppLanguage(rawValue: languageRaw) else {
            return format
        }
    
        if language == .chinese {
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
    }
    /// Converts separate UTC date and time strings to local time zone formatted string
    /// - Parameters:
    ///   - date: The date string in "yyyy-MM-dd" format
    ///   - time: The time string in "HH:mm:ssZ" format
    ///   - format: The desired output format (default: "yyyy-MM-dd HH:mm:ss")
    /// - Returns: A formatted string in the local time zone
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
}
