//
//  ScheduleView.swift
//  Pit Hub
//
//  Created by Junyu Yao on 12/3/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ScheduleItem: Identifiable {
    var id = UUID()
    var curYear: Int
}

struct ScheduleView: View {
    @State private var scheduleItems = [ScheduleItem]()

    var body: some View {
        List(scheduleItems) { item in
            HStack {
                Text("\(item.curYear)") // Convert Int to String
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Schedule")
        .onAppear {
            fetchScheduleItems()
        }
    }

    private func fetchScheduleItems() {
        let db = Firestore.firestore()
        db.collection("info").getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot = snapshot {
                    self.scheduleItems = snapshot.documents.map { doc in
                        let data = doc.data()
                        return ScheduleItem(curYear: data["curYear"] as? Int ?? 0)
                    }
                }
            }
        }
    }
}

#Preview {
    ScheduleView()
}
