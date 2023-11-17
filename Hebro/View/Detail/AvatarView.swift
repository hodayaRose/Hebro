//
//  AvatarView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//
//Avatar view is being used to show a logged out / not signed user profile picture
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct AvatarView: View {
    @Binding var showProfile: Bool
    @EnvironmentObject var databaseService: DatabaseManager
    @EnvironmentObject var alertManager: AlertManager // Add AlertManager as an environment object
    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
    

    var body: some View {
        VStack {
            ///if user is logged in
            if databaseService.isLogged { /// Use databaseService.isLogged
                Button(action: {self.showProfile.toggle()}){
                    ///Avatar component button
                    Avatar()
                }
            }
            else {
                ///if user is not logged in
                Button(action: {self.databaseService.showLogin.toggle()}){ /// Use databaseService.showLogin instead of user.showLogin
                    ///featurebutton
                    FeatureButton(name: "person")
                       
                }
            }
        }
        .onChange(of: databaseService.isLogged) {
            handleUserLoginChange(isLogged: databaseService.isLogged)
              }


        .alert(isPresented: $alertManager.showAlert) { // Alert modifier
            Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
        }
        
    }
    
    ///functions onChange()
    private func handleUserLoginChange(isLogged: Bool) {
           guard UserDefaults.standard.bool(forKey: "isRegistered") else { return }

           if isLogged {
               fetchAvatarIndexAndUserName()
           } else {
               print("User is not logged in.")
           }
       }

       private func fetchAvatarIndexAndUserName() {
           databaseService.fetchAvatarIndex(welcomeViewManager: welcomeViewManager) { error in
               if let error {
                   print("Error fetching avatar index: \(error)")
                   self.welcomeViewManager.avatarIndex = 1
                   self.alertManager.alertMessage = "Error fetching avatar index: \(error.localizedDescription)"
                   self.alertManager.showAlert = true
               }
               print("debug avatarview: \(self.welcomeViewManager.avatarIndex)")
           }

           databaseService.fetchAndStoreUserName { userName, error in
               if let error = error {
                   print("Error: \(error.localizedDescription)")
                   self.alertManager.alertMessage = "Error: \(error.localizedDescription)"
                   self.alertManager.showAlert = true
               } else if let userName = userName {
                   print("Fetched user name: \(userName)")
               } else {
                   print("Document not found or the 'name' field is missing.")
                   self.alertManager.alertMessage = "Document not found or the 'name' field is missing."
                   self.alertManager.showAlert = true
               }
           }

           print("debug avatarview userName: \(databaseService.userName)")
       }
}


