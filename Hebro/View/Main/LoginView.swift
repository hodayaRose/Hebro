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
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @EnvironmentObject var alertManager : AlertManager

    @State var isLoading = false
    @State var isSuccessful = false
//    @Binding var userName : String
    @EnvironmentObject var databaseService: DatabaseManager
    @Environment(\.dismiss) private var dismiss
   
//    func fetchUserName (){
//        if databaseService.isLogged{
//            databaseService.fetchCurrentUserName { name, error in
//                if let error {
//                    
//                    self.alertManager.alertMessage  = "Error fetching current user name: \(error.localizedDescription)"
//                    self.alertManager.showAlert = true
//                } else if let name {
//                    print("Fetched current user name: \(name)")
//                    // set userName to fetched name
//                    self.userName = name
//                    print(\(self.loggedUserName))
//                } else {
//                    print("Debug: Current user document does not exist or the 'name' field is missing (fetchUserName())")
//                    //in case the user name is nil the default set value will be used - "User"
//                    
//                }
//            }
//        }
//
//    }
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
                print("user is logged in ")
                
                
                
              

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
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .top) {
                
                K.Colors.bkgColor2
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .offset(y: isFocused ? -40 : 0)
                    .edgesIgnoringSafeArea(.bottom)
                
                CoverView()
                   .offset(y: isFocused ? 3 : 0)
                    
                
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(K.Colors.bkgColor1)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        TextField("Your Email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                        }
                    }
                    
                    Divider().padding(.leading, 80)
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(K.Colors.bkgColor1)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        
                        SecureField("Password".uppercased(), text: $password)
                            .keyboardType(.default)
                            .font(.subheadline)
                            //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                self.isFocused = true
                        }
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: 712)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: isFocused ? 280 : 500)
                
                HStack {
                    Text("Forgot password?")
                        .font(.subheadline)
                        .onTapGesture {
                        print("forgotpassword tapped")
                        }
                    
                    Spacer()
                    //Login Button
                    Button(action: {
                        self.login()
                     
                    }) {
                        Text("Log in").foregroundColor(.black)
                    }
                    .padding(15)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0.7529411765, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $alertManager.showAlert) {
                        Alert(title: Text("Error"), message: Text(self.alertManager.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
                //offsets the login button
                .offset(y:isFocused ? 10 : 0)
                
            }
           .offset(y: isFocused ? -40 : 0)
           // .animation(.easeInOut /*,value: isFocused*/)
            .onTapGesture {
                self.isFocused = false
                self.hideKeyboard()
            }
            
            if isLoading {
                LoadingView()
                
            }
            
            if isSuccessful {
               
                //Home()
                SuccessView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView( ).environmentObject(DatabaseManager())
            .environmentObject(AlertManager())
//        .previewDevice("iPad Air 2")
    }
}



