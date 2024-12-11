//
//  Pit_HubApp.swift
//  Pit Hub
//
//  Created by Junyu Yao on 11/29/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    checkFirebaseConnection()
    return true
  }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
      checkFirebaseConnection()
    }

    private func checkFirebaseConnection() {
        if FirebaseApp.app() == nil {
            // Handle the error, for instance, show an alert to the user
            print("Firebase configuration failed.")
        } else {
            // Optionally, you can perform additional checks or log success
            print("Firebase is configured successfully!")
        }
    }
}

@main
struct Pit_HubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
