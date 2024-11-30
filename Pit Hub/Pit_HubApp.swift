//
//  Pit_HubApp.swift
//  Pit Hub
//
//  Created by Junyu Yao on 11/29/24.
//

import SwiftUI

@main
struct Pit_HubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
