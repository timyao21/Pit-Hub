//
//  FirestoreDriversManager.swift
//  Pit Hub
//
//  Created by Junyu Yao on 2/8/25.
//


import Foundation
import FirebaseCore
import FirebaseFirestore


struct FirestoreDriversManager {
    private let db = Firestore.firestore() // Firestore instance

    func fetchDrivers(for year: Int) async throws -> [F1Driver] {
        print("Fetching Firestore Drivers for year \(year)...")

        let snapshot = try await db.collection("f1SeasonDrivers")
            .whereField("season", isEqualTo: year) // Filter by year
            .getDocuments()

        var fetchedDrivers: [F1Driver] = snapshot.documents.compactMap { document in
            try? document.data(as: F1Driver.self) // Decode Firestore document directly
        }

        // Sort drivers by race points in descending order
        fetchedDrivers.sort { $0.raceStats.points > $1.raceStats.points }
        
        print("Successfully fetched \(fetchedDrivers.count) drivers.")
        return fetchedDrivers
    }
    
    func fetchTeam(for year: Int) async throws -> [F1Team] {
        print("Fetching Firestore Drivers for year \(year)...")
        
        let snapshot = try await db.collection("f1Teams")
            .whereField("year", isEqualTo: year) // Filter by year
            .getDocuments()

        var fetchedTeams: [F1Team] = snapshot.documents.compactMap { document in
            try? document.data(as: F1Team.self) // Decode Firestore document directly
        }

        // Sort drivers by race points in descending order
        fetchedTeams.sort { $0.points > $1.points }
        
        print("Successfully fetched \(fetchedTeams.count) Teams.")
        return fetchedTeams
        
    }
    
    func fetchGrandPrix(for year: Int) async throws -> [GrandPrix] {
        print("Fetching Firestore Grand Prix for year \(year)...")
        
        let snapshot = try await db.collection("GrandPrix")
            .whereField("year", isEqualTo: year)
            .getDocuments()
        
        var fetchedGrandPrix: [GrandPrix] = snapshot.documents.compactMap { document in
            try? document.data(as: GrandPrix.self) // Decode Firestore document directly
        }
        
        fetchedGrandPrix.sort { $0.meetingKey > $1.meetingKey }
        
        print("Successfully fetched \(fetchedGrandPrix.count) Teams.")
        return fetchedGrandPrix
        
    }

}
    
