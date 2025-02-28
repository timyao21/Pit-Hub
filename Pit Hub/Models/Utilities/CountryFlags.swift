//
//  CountryFlags.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/13/25.
//

import Foundation

struct CountryFlags {
    // Dictionary mapping full country names to flag emojis
    static let flags: [String: String] = [
        "Bahrain": "🇧🇭",
        "Saudi Arabia": "🇸🇦",
        "Australia": "🇦🇺",
        "Australian": "🇦🇺",
        "Japan": "🇯🇵",
        "Japanese": "🇯🇵",
        "China": "🇨🇳",
        "Chinese": "🇨🇳",
        "United States": "🇺🇸",
        "Italy": "🇮🇹",
        "Monaco": "🇲🇨",
        "Canada": "🇨🇦",
        "Spain": "🇪🇸",
        "Spanish": "🇪🇸",
        "Austria": "🇦🇹",
        "Austrian": "🇦🇹",
        "United Kingdom": "🇬🇧",
        "Hungary": "🇭🇺",
        "Belgium": "🇧🇪",
        "Netherlands": "🇳🇱",
        "Azerbaijan": "🇦🇿",
        "Singapore": "🇸🇬",
        "Mexico": "🇲🇽",
        "Mexican": "🇲🇽",
        "Brazil": "🇧🇷",
        "Qatar": "🇶🇦",
        "United Arab Emirates": "🇦🇪",
        "Germany": "🇩🇪",
        "German": "🇩🇪",
        "France": "🇫🇷",
        "French": "🇫🇷",
        "Switzerland": "🇨🇭",
        "Swiss": "🇨🇭",
        "Italian": "🇮🇹",
        "British": "🇬🇧",
        "American": "🇺🇸",
        "USA": "🇺🇸",
        "Thai": "🇹🇭",
        "Finnish": "🇫🇮",
        "Argentinian": "🇦🇷",
        "New Zealander": "🇳🇿",
        "Monegasque": "🇲🇨",
        "Danish": "🇩🇰",
        "Canadian": "🇨🇦",
        "Dutch": "🇳🇱"
    ]
    
    /// Retrieves the flag emoji for a given full country name, or returns a default flag if not found.
    static func flag(for countryName: String) -> String {
        return flags[countryName] ?? " " // Default to a white flag
    }
}

