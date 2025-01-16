//
//  MeetingsManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import Foundation

struct MeetingsManager: Codable {
    
    // MARK: - Convert date string to Date
    private func convertToDate(dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString)
    }
    
    // MARK: - get the full schedule (input Year, output [Meeting])
    func getFullSchedule(_ year: Int, completion: @escaping ([Meeting]?) -> Void) {
        guard let url = URL(string: "https://api.openf1.org/v1/meetings?year=\(year)") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            do {
                let meetings = try JSONDecoder().decode([Meeting].self, from: data)
                print(meetings.count)
                completion(meetings)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - Filter and return upcoming meetings
    func getUpcomingMeetings(from meetings: [Meeting]) -> [Meeting] {
        
        // Test
        guard let testDate = convertToDate(dateString: "2024-11-19T09:30:00+00:00") else {
            print("Invalid test date format")
            return []
        }
        
        return meetings.filter { meeting in
            if let date = convertToDate(dateString: meeting.dateStart) {
                return date > testDate
            }
            return false
        }
    }
    
    // MARK: - Filter and return past meetings
    func getPastMeetings(from meetings: [Meeting]) -> [Meeting] {
        
        // Test
        guard let testDate = convertToDate(dateString: "2024-11-19T09:30:00+00:00") else {
            print("Invalid test date format")
            return []
        }
        
        return meetings.filter { meeting in
            if let date = convertToDate(dateString: meeting.dateStart) {
                return date < testDate
            }
            return false
        }
    }

    
}
