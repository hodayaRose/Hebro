//
//  HebroApp.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/24/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseCore
import Foundation


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        
        return true
    }
}


@main
struct HebroApp: App {
    @StateObject var databaseService = DatabaseManager()
    @StateObject var dataSource = NotificationManager()
    @StateObject var alertManager = AlertManager()
    @StateObject var welcomeViewManager: WelcomeViewManager
    @StateObject var userStore = UserStore()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        let databaseService = DatabaseManager()
        let alertManager = AlertManager()
        _databaseService = StateObject(wrappedValue: databaseService)
        _alertManager = StateObject(wrappedValue: alertManager)
        _welcomeViewManager = StateObject(wrappedValue: WelcomeViewManager(databaseService: databaseService, alertManager: alertManager))
    }
    
    var body: some Scene {
       
        WindowGroup {
              if userStore.isRegistered {
                  Home()
                      .environmentObject(dataSource)
                      .environmentObject(databaseService)
                      .environmentObject(alertManager)
                      .environmentObject(welcomeViewManager)
              } else {
                  WelcomeView()
                      .environmentObject(dataSource)
                      .environmentObject(databaseService)
                      .environmentObject(alertManager)
                      .environmentObject(welcomeViewManager)
              }
            
          }
    }
}
