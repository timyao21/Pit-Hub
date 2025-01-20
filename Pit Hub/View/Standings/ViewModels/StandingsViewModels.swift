//
//  StandingsViewModels.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/15/25.
//
import Foundation
import FirebaseCore
import FirebaseFirestore

extension StandingsView {
    class ViewModel: ObservableObject {
        private let db = Firestore.firestore()
        
//        @Published var drivers: [Driver] = []
        @Published var drivers: [Driver] = [Driver(
            id: UUID(),
            broadcastName: "M VERSTAPPEN",
            countryCode: "NED",
            driverNumber: 1,
            firstName: "Max",
            fullName: "Max Verstappen",
            lastName: "Verstappen",
            nameAcronym: "VER",
            points: 395,
            teamColour: "3671C6",
            teamName: "Red Bull Racing"
        ),
                                            Driver(
            id: UUID(),
            broadcastName: "M VERSTAPPEN",
            countryCode: "NED",
            driverNumber: 1,
            firstName: "Max",
            fullName: "Max Verstappen",
            lastName: "Verstappen",
            nameAcronym: "VER",
            points: 395,
            teamColour: "3671C6",
            teamName: "Red Bull Racing"
        )]
        
        func fetchDrivers() {
            print("Fetching drivers from Firestore...")
            
            let driverCollectionRef = db.collection("F1Drivers").document("2024").collection("Drivers")
            
            driverCollectionRef.getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching driver IDs: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No drivers found.")
                    return
                }
                
                var fetchedDrivers: [Driver] = []
                
                for document in documents {
                    let driverID = document.documentID // e.g., "VAR", "VER", etc.
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        if let driver = try? JSONDecoder().decode(Driver.self, from: jsonData) {
                            fetchedDrivers.append(driver)
                        } else {
                            print("Decoding failed for driverID: \(driverID)")
                        }
                    } catch {
                        print("Error decoding data for driverID: \(driverID): \(error.localizedDescription)")
                    }
                }
                fetchedDrivers.sort { $0.points > $1.points }
                DispatchQueue.main.async {
                    self?.drivers = fetchedDrivers
                    print("Successfully fetched \(fetchedDrivers.count) drivers.")
                    print(fetchedDrivers)
                }
            }
        }

        
    }
}
