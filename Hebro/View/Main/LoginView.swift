//
//  LoginView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/31/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State var isFocused = false
    @EnvironmentObject var alertManager : AlertManager
    
    @State var isLoading = false
    @State var isSuccessful = false
   
    @EnvironmentObject var databaseService: DatabaseManager
    @Environment(\.dismiss) private var dismiss
    
    @State var isLandscape = false
    
    
    func login() {
        self.hideKeyboard()
        self.isFocused = false
        self.isLoading = true
        
        databaseService.loginUser(email: email, password: password) { error in
            self.isLoading = false
            
            if let error {
                self.alertManager.alertMessage  = "Error logging in: \(error.localizedDescription)"
                self.alertManager.showAlert = true
            } else {
                self.isSuccessful = true
                
                self.databaseService.isLogged = true // UPDATE
                print("Debug: user is logged in ")
                
                
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.email = ""
                    self.password = ""
                    self.isSuccessful = false
                    
                    self.databaseService.showLogin = false
                }
            }
        }
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        GeometryReader { geometry in
            
        
          
            ZStack {
                ///background color
                K.Colors.bkgColor2.edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .top) {
                    
                    K.Colors.bkgColor2
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .offset(y: isFocused ? -40 : 0)
                        .edgesIgnoringSafeArea(.bottom)
                    ///coverview layout card
                    CoverView()
                        .offset(y: isFocused ? -6 : 3)
                        .onTapGesture {
                            isFocused = true
                        }//NEW
                       
                    
                    ///email & password textfield component
                    LoginInputComponent(email: $email, password: $password, isFocused: $isFocused)
                        .frame(height: 136)
                        .frame(maxWidth: 712)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                        .padding(.horizontal)
                        .offset(y: isFocused ? 260 : 500)
                       // .offset(y: isLandscape ? -283 : 0)
                    
                    
                    
                    ///forgot password&login button layout
                    LoginButtonRow(onLogin: login)
                    ///offsets the login button
                        .offset(y:isFocused ? 11 : 0)
                      //  .offset(x: isLandscape ? -20 : 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .padding()
                        .alert(isPresented: $alertManager.showAlert) {
                            Alert(title: Text("Error"), message: Text(self.alertManager.alertMessage), dismissButton: .default(Text("OK")))
                        }
                    
                    
                }///zstack closure
                .offset(y: isFocused ? -40 : 0)
                .animation(.easeInOut ,value: isFocused)
                ///when tapping the background view / the return key  in  keyboard
                .onTapGesture {
                    self.isFocused = false
                    self.hideKeyboard()
                }
                
                if isLoading {
                    LoadingView()
                    
                }
                
                if isSuccessful {
                    
                    SuccessView()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            // The GeometryReader's size is used to initially set the orientation
            .onAppear {
                          self.isLandscape = geometry.size.width > geometry.size.height
                      }
            .onChange(of: geometry.size.width > geometry.size.height) { isNowLandscape in
                self.isLandscape = isNowLandscape
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView( ).environmentObject(DatabaseManager())
            .environmentObject(AlertManager())
        
    }
}




