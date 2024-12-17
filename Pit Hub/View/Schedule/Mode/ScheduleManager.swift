//
//  File.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct ScheduleManager: Codable {
    let year: Int
    
    init(year: Int) {
        self.year = year
    }
    
    // MARK: - get the Full Schedule
    
    func getFullSchedule(completion: @escaping ([Meeting]?) -> Void) {
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
                completion(meetings)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    // MARK: - Helper function to convert String to Date
    private func convertToDate(dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString)
    }
    
    // MARK: - Return upcoming meetings
    func getUpcomingMeetings(completion: @escaping ([Meeting]?) -> Void) {
        getFullSchedule { meetings in
            let upcomingMeetings = meetings?.filter {
                if let date = self.convertToDate(dateString: $0.dateStart) {
                    return date > Date()
                }
                return false
            }
            completion(upcomingMeetings)
        }
    }
    
    // MARK: - Return past meetings
    func getPastMeetings(completion: @escaping ([Meeting]?) -> Void) {
        getFullSchedule { meetings in
            let pastMeetings = meetings?.filter {
                if let date = self.convertToDate(dateString: $0.dateStart) {
                    return date <= Date()
                }
                return false
            }
            completion(pastMeetings)
        }
    }
    
}
