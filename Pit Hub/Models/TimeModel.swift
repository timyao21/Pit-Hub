//
//  TimeModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/5/24.
//

import Foundation

struct TimeModel{
    let isoDateString: String
    
    init(isoDateString: String) {
        self.isoDateString = isoDateString
    }
    
    func toLocalDateTimeString() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = dateFormatter.date(from: isoDateString) else {
            print("Failed to parse date: \(isoDateString)")
            return nil
        }
        
        let localDateFormatter = DateFormatter()
        localDateFormatter.dateStyle = .short
        localDateFormatter.timeStyle = .short
        localDateFormatter.timeZone = TimeZone.current
        
        return localDateFormatter.string(from: date)
    }
    
    func toLocalDateString() -> String? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        guard let date = dateFormatter.date(from: isoDateString) else {
            print("Failed to parse date: \(isoDateString)")
            return nil
        }
        
        let localDateFormatter = DateFormatter()
        localDateFormatter.dateStyle = .short
        localDateFormatter.timeStyle = .none
        localDateFormatter.timeZone = TimeZone.current
        
        return localDateFormatter.string(from: date)
    }
    
    func toLocalDate() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        // Parse the ISO 8601 date string
        guard let date = dateFormatter.date(from: isoDateString) else {
            print("Failed to parse date: \(isoDateString)")
            return nil
        }
        
        // Convert to local time zone
        let timeZoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        let localDate = date.addingTimeInterval(timeZoneOffset)
        
        return localDate
    }
    
}
