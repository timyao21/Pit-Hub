//
//  SessionManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/19/24.
//

import Foundation


struct SessionManager {
    
    // MARK: - Convert date string to Date
    func convertToDate(dateString: String) -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: dateString)
    }
    
    // MARK: - get all sessions
    func getAllSessions(_ meetingKey: Int, for_ year: Int, completion: @escaping ([Session]?) -> Void) {
        guard let url = URL(string: "https://api.openf1.org/v1/sessions?year=\(year)&meeting_key=\(meetingKey)") else {
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
                let sessions = try JSONDecoder().decode([Session].self, from: data)
                completion(sessions)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }

    
}

