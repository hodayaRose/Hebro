//
//  DatabaseService.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/15/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class DatabaseManager: ObservableObject {
    /*By using lazy, the Firestore instance (db) will only be created the first time it's accessed, ensuring that it's created after FirebaseApp.configure() has been called*/
    private lazy var db: Firestore = {
        return Firestore.firestore()
    }()
    @Published var isLogged: Bool = false
    @Published var showLogin: Bool = false // true if the login view should be shown, false otherwise
    @Published var userName : String = "User"
    
    
    var userStore = UserStore()
    // Register a new user
    func registerUser(avatarIndex: Int, name: String, age: String, email: String, password: String, completion: @escaping (Int?, Error?) -> Void) {
        
        // Attempt to create a new user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            // Handle any errors during user creation
            if let error  {
                completion(nil, error)
                return
            }
            
            // Ensure we have a user ID from the result
            guard let uid = result?.user.uid else {
                completion(nil, NSError(domain: "No user ID found", code: 0, userInfo: nil))
                return
            }
            
            // Double-check that the user is authenticated using Auth.auth().currentUser
            guard let currentUser = Auth.auth().currentUser, currentUser.uid == uid else {
                completion(nil, NSError(domain: "User not authenticated", code: 0, userInfo: nil))
                return
            }
            
            // Define the user data to store in Firestore
            let userData: [String: Any] = [
                "avatar": avatarIndex,
                "email": email,
                "isLogged": true,
                "name": name,
                "age": age,
                "password" : "123"
                
                
            ]
            
            // Attempt to store the user data in Firestore
            self.db.collection("users").document(uid).setData(userData) { error in
                
                // Handle any errors during data storage
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                // Update local states
                self.isLogged = true
                self.userStore.isRegistered = true
                completion(avatarIndex, nil)
            }
        }
    }
    
    
    
    // Login an existing user
    
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if (result?.user.uid) != nil {
                self.isLogged = true
                print("Debug isLogged state : \(self.isLogged) ")
//                self.fetchUserLoggedInState(userID: uid) { (isLogged, _) in
//                   
//                }
              
            }
            completion(error)
        }
    }
    
    // Logout the current user
    func logoutUser(completion: @escaping (Error?) -> Void) {
        do {
            if let uid = Auth.auth().currentUser?.uid {
                self.updateUserLoggedInState(uid: uid, isLogged: false) { _ in }
            }
            try Auth.auth().signOut()
            self.isLogged = false
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func updateUserLoggedInState(uid: String, isLogged: Bool, completion: @escaping (Error?) -> Void) {
        self.db.collection("users").document(uid).updateData([
            "isLogged": isLogged
        ]) { error in
            completion(error)
        }
    }
    
    func fetchAndStoreUserName() {
         // Check if there's a current user logged in
         guard let userID = Auth.auth().currentUser?.uid else {
             print("No user is currently logged in.")
             return
         }

         // Proceed to fetch the user's name using their userID
         db.collection("users").document(userID).getDocument { [weak self] (document, error) in
             if let document = document, document.exists {
                 let name = document.data()?["name"] as? String ?? "User"
                 DispatchQueue.main.async {
                     self?.userName = name
                     print("\(self?.userName ?? "lola")")
                 }
             } else if let error {
                 print("Error fetching current user name: \(error.localizedDescription)")
                 // need to handle error here
             } else {
                 print("Document does not exist or the 'name' field is missing.")
             }
         }
     }


//    func fetchUserLoggedInState(userID: String, completion: @escaping (Bool?, Error?) -> Void) {
//        db.collection("users").document(userID).getDocument { (document, error) in
//            if let document = document, document.exists {
//                let isLogged = document.data()?["isLogged"] as? Bool ?? false
//                completion(isLogged, nil)
//            } else {
//                completion(nil, error)
//            }
//        }
//    }
    
    func fetchAvatarIndex(welcomeViewManager: WelcomeViewManager, completion: @escaping (Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "No user ID found", code: 0, userInfo: nil))
            return
        }
        
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                let avatarIndexDataBase = document.data()?["avatar"] as? Int ?? 1
                welcomeViewManager.avatarIndex = avatarIndexDataBase // Update the shared state
                print("updated avatar index is \(avatarIndexDataBase)")
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
 
    
}

