import Foundation

struct GrandPrix: Codable {
    let year: Int
    let country_code: String
    let session_name: String
    let date_start: String
    let gmt_offset: String
    let circuit_short_name: String
    
    // Providing default values for the initializer parameters
    init(year: Int = 2024, country_code: String = "xxx", session_name: String = "xxxxxx", date_start: String = "2023-07-29T15:05:00+00:00", gmt_offset: String = "02:00:00", circuit_short_name: String = "xxxxxxxxxx") {
        self.year = year
        self.country_code = country_code
        self.session_name = session_name
        self.date_start = date_start
        self.gmt_offset = gmt_offset
        self.circuit_short_name = circuit_short_name
    }
}

func filterSessions(by sessionName: String, from data: Data) -> [GrandPrix]? {
    do {
        let meetings = try JSONDecoder().decode([GrandPrix].self, from: data)
        let filteredMeetings = meetings.filter { $0.session_name == sessionName }
        return filteredMeetings
    } catch {
        print("Error decoding data: \(error.localizedDescription)")
        return nil
    }
}

func getGrandPrix(year: Int, country_code: String, completion: @escaping ([GrandPrix]?) -> Void) {
    guard let url = URL(string: "https://api.openf1.org/v1/sessions?country_code=\(country_code)&year=\(year)") else {
        print("Invalid URL")
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let data = data else {
            print("No data received")
            completion(nil)
            return
        }

        do {
            let meetings = try JSONDecoder().decode([GrandPrix].self, from: data)
            let filteredMeetings = meetings.filter { $0.session_name == "Race" || $0.session_name == "Qualifying" }
            print(filteredMeetings.count)
            completion(filteredMeetings.isEmpty ? nil : filteredMeetings)
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            completion(nil)
        }
    }.resume()
}
