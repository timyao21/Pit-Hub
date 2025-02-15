//
//  DateUtilities.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/15/25.
//

import Foundation


struct DateUtilities {
    
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
}
