import Foundation

struct RaceResult: Codable, Identifiable {
    var id = UUID()
    let firstName: String
    let fullName: String
    let lastName: String
    let points: Int
    let dnf: Bool
    let dns: Bool
    let fastestLap: Bool
    let gap: Double
    let position: Int
    let intValue: Int
    let time: String
    let lapsCompleted: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case fullName = "full_name"
        case lastName = "last_name"
        case points
        case dnf
        case dns
        case fastestLap = "fastest_lap"
        case gap
        case position
        case intValue = "int"
        case time
        case lapsCompleted = "laps_completed"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        firstName = try container.decode(String.self, forKey: .firstName)
        fullName = try container.decode(String.self, forKey: .fullName)
        lastName = try container.decode(String.self, forKey: .lastName)
        points = try container.decode(Int.self, forKey: .points)
        position = try container.decode(Int.self, forKey: .position)
        lapsCompleted = try container.decode(Int.self, forKey: .lapsCompleted)

        // ✅ Properly decode `Bool` values, allowing both `Int` and `Bool` storage formats
        dnf = (try? container.decode(Bool.self, forKey: .dnf)) ?? (try? container.decode(Int.self, forKey: .dnf) == 1) ?? false
        dns = (try? container.decode(Bool.self, forKey: .dns)) ?? (try? container.decode(Int.self, forKey: .dns) == 1) ?? false
        fastestLap = (try? container.decode(Bool.self, forKey: .fastestLap)) ?? (try? container.decode(Int.self, forKey: .fastestLap) == 1) ?? false


        // ✅ Handle `int` stored as `Double`
        if let intAsDouble = try? container.decode(Double.self, forKey: .intValue) {
            intValue = Int(intAsDouble) // Convert to `Int`
        } else {
            intValue = try container.decode(Int.self, forKey: .intValue)
        }

        // ✅ Handle `gap`, allowing both `Int` and `Double`
        if let gapAsInt = try? container.decode(Int.self, forKey: .gap) {
            gap = Double(gapAsInt)
        } else {
            gap = try container.decode(Double.self, forKey: .gap)
        }

        // ✅ Ensure `time` is always a `String`
        if let timeString = try? container.decode(String.self, forKey: .time) {
            time = timeString.isEmpty ? "N/A" : timeString
        } else {
            time = "N/A" // Default for missing or invalid values
        }
    }
}
