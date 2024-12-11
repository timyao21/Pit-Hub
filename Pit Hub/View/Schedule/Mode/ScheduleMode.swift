//
//  File.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/11/24.
//

import Foundation

struct ScheduleMode: Codable {
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
        print(url)
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
    
    
}
