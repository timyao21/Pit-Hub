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
        
        @Published var selectedYear = 2024
        @Published var F1Drivers: [F1Driver] = []
        
        // MARK: - Change the Calendar Year
        func changeYear(year: Int) {
            self.selectedYear = year
        }
        
        // MARK: - Fetch the drivsers
        func fetchDrivers(_ year: Int) {
            print("Fetching drivers from Firestore...")
            
            let driverCollectionRef = db.collection("f1SeasonDrivers")
            
            driverCollectionRef.getDocuments { [weak self] snapshot, error in
                if let error = error {
                    print("Error fetching driver IDs: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No drivers found.")
                    return
                }
                
                var fetchedDrivers: [F1Driver] = []
                
                for document in documents {
                    let driverID = document.documentID // e.g., "VAR", "VER", etc.
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        if let driver = try? JSONDecoder().decode(F1Driver.self, from: jsonData) {
                            fetchedDrivers.append(driver)
                        } else {
                            print("Decoding failed for driverID: \(driverID)")
                        }
                    } catch {
                        print("Error decoding data for driverID: \(driverID): \(error.localizedDescription)")
                    }
                }
                fetchedDrivers.sort { $0.raceStats.points > $1.raceStats.points }
                DispatchQueue.main.async {
                    self?.F1Drivers = fetchedDrivers
                    print("Successfully fetched \(fetchedDrivers.count) drivers.")
//                    print(fetchedDrivers)
                }
            }
        }
        
        
    }
}
