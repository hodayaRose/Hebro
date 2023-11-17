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
            //if user is logged in
            if databaseService.isLogged { // Use databaseService.isLogged
                Button(action: {self.showProfile.toggle()}){
                    //Avatar component
                    Avatar()
                }
            }
            else {
                //if user is not logged in
                Button(action: {self.databaseService.showLogin.toggle()}){ // Use databaseService.showLogin instead of user.showLogin
                    FeatureButton(name: "person")
                       // .foregroundColor(.black)
                }
            }
        }
        .onChange(of: databaseService.isLogged) {
            // Check if the user has registered
            if UserDefaults.standard.bool(forKey: "isRegistered") {
                // Check if the user is logged in
                if databaseService.isLogged  {
                    // Fetch the avatar index for the logged-in user
                    databaseService.fetchAvatarIndex(welcomeViewManager: welcomeViewManager) { error in
                        if let error {
                            print("Error fetching avatar index: \(error)")
                            welcomeViewManager.avatarIndex = 1 // Set avatar index to 1 to show the default avatar if there's an error
                            alertManager.alertMessage = "Error fetching avatar index: \(error.localizedDescription)"
                            alertManager.showAlert = true // Show alert
                        }
                        print("debug avatarview: \(welcomeViewManager.avatarIndex)")
                    }
                    databaseService.fetchAndStoreUserName()//UPDATE HANDLE ERRORS ASAP
                    print("debug avatarview: \(databaseService.userName)")
                    
                } else{
                   // welcomeViewManager.avatarIndex = 1 // Set avatar index to 1 if the user is not logged in
                    
                    print(" Set avatar index is not available, user is not logged in.")
                }
            }
        }

        .alert(isPresented: $alertManager.showAlert) { // Alert modifier
            Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

