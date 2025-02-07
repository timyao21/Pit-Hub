//
//  ScheduleDetailViewModel.swift
//  Pit Hub
//
//  Created by Junyu Yao on 1/12/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

extension ScheduleDetailView {
    
    class ViewModel: ObservableObject{
        private let db = Firestore.firestore()
        
        @Published var documentID: String = ""  // Store only the document ID
        @Published var raceResults: [RaceResult] = [] // Store results subcollection
        @Published var sprintRaceResults: [RaceResult] = [] // Store results subcollection
        
        private let sessionManager = SessionManager()
        @Published var sessions: [Session] = []
        @Published var startDate = ""
        @Published var endDate = ""
        
        func fetchSessions(_ meetingKey: Int, for startDate: String){
            let date = sessionManager.convertToDate(dateString: startDate) ?? Date() // Use current date as fallback
            let year = Calendar.current.component(.year, from: date)
            sessionManager.getAllSessions(meetingKey, for_: year) { sessions in
                DispatchQueue.main.async {
                    self.sessions = sessions ?? []
                    if let startSession = self.sessions.first, let endSession = self.sessions.last {
                        self.startDate = DateUtils.formatLocalDateString(startSession.dateStart) ?? ""
                        self.endDate = DateUtils.formatLocalDateString(endSession.dateStart) ?? ""
                    }
                }
            }
        }
        
        @MainActor
        func fetchRaceResults(for meetingKey: Int) async {

            do {
                let resultsSnapshot = try await db.collection("GrandPrix").document("\(meetingKey)").collection("Race_Results").getDocuments()

                var fetchedResults: [RaceResult] = resultsSnapshot.documents.compactMap { document in
                    let rawData = document.data()

                    do {
                        let result = try document.data(as: RaceResult.self)
                        return result
                    } catch {
                        print("Raw Firestore Data: \(rawData)")
                        print("❌ Decoding failed for document \(document.documentID): \(error)")
                        return nil
                    }
                }
                
                fetchedResults.sort {
                    if $0.position < 0 && $1.position >= 0 { return false } // Push negative positions to the end
                    if $0.position >= 0 && $1.position < 0 { return true }  // Keep valid positions at the top
                    
                    if $0.position == $1.position {
                        return $0.lapsCompleted > $1.lapsCompleted // More laps first
                    }
                    return $0.position < $1.position // Lower position first
                }

                DispatchQueue.main.async {
                    self.raceResults = fetchedResults
                }
                
                print("Total Results Fetched: \(fetchedResults.count)")

            } catch {
                print("❌ Error fetching results: \(error.localizedDescription)")
            }
        }
        
        @MainActor
        func fetchSprintRaceResults(for meetingKey: Int) async {
            do {
                let sprintRaceResultsSnapshot = try await db.collection("GrandPrix").document("\(meetingKey)").collection("Sprint_Results").getDocuments()
                
                var fetchedSprintResults: [RaceResult] = sprintRaceResultsSnapshot.documents.compactMap { document in
                    let rawData = document.data()

                    do {
                        let result = try document.data(as: RaceResult.self)
                        return result
                    } catch {
                        print("Raw Firestore Data: \(rawData)")
                        print("❌ Decoding failed for document \(document.documentID): \(error)")
                        return nil
                    }
                }
                
                fetchedSprintResults.sort {
                    if $0.position < 0 && $1.position >= 0 { return false } // Push negative positions to the end
                    if $0.position >= 0 && $1.position < 0 { return true }  // Keep valid positions at the top
                    
                    if $0.position == $1.position {
                        return $0.lapsCompleted > $1.lapsCompleted // More laps first
                    }
                    return $0.position < $1.position // Lower position first
                }
                
                DispatchQueue.main.async {
                    self.sprintRaceResults = fetchedSprintResults
                }
                print("Total Sprint Results Fetched: \(fetchedSprintResults.count)")
                
            }catch {
                print("❌ Error fetching results: \(error.localizedDescription)")
            }
            
        }

        
    }
    
}
