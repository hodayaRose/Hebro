//
//  WelcomeViewManager.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/16/23.
//

import Foundation
import SwiftUI

///WelcomeViewManager orchestrates registration, handles UI state, and manages alerts.
class WelcomeViewManager :ObservableObject{
     @Published var avatarIndex: Int = 1
    @Published var isPresentingHomeView: Bool = false
    
    var alertManager: AlertManager
    var databaseService: DatabaseManager
    
    init(databaseService: DatabaseManager, alertManager: AlertManager) {
        self.databaseService = databaseService
        self.alertManager = alertManager
    }
    
    func submit(name: String, age: String, email: String, password: String) {
        // Validate all fields are filled
        guard !name.isEmpty, !age.isEmpty, !email.isEmpty, !password.isEmpty else {
            // Show an error message
            alertManager.alertMessage="All fields are required."
            alertManager.showAlert = true
            return
        }

        self.databaseService.registerUser(avatarIndex: avatarIndex, name: name, age: age, email: email, password: password) { (index, error) in
            if let error {
                self.alertManager.alertMessage =  "Error registering user: \(error.localizedDescription)"
                self.alertManager.showAlert=true
                
            } else {
                UserDefaults.standard.set(true, forKey: "isRegistered")
         //       self.avatarIndex = index ?? 1 // Update the avatar index, or use a default value if it's nil
               
                self.isPresentingHomeView = true
            }
        }
    }
}

