//
//  Pit_HubApp.swift
//  Pit Hub
//
//  Created by Junyu Yao on 11/29/24.
//

import SwiftUI

//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        
//        return true
//    }
//    
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        
//    }
//}

@main
struct Pit_HubApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
