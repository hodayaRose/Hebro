//
//  MenuBodyView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/10/23.
//

import SwiftUI
//the menu view component
// MARK: - MenuBodyView
struct MenuBodyView: View {
   @State var MenueIcons: [String: String] = [
        "Account": "gear",
        "Billing": "creditcard",
        "Sign Out": "person.crop.circle"]
    
    @Binding var showProfile: Bool
    
    @EnvironmentObject var databaseService: DatabaseManager
    @EnvironmentObject var alertManager: AlertManager

    var body: some View {
       
        VStack(spacing: 16) {
           
            UserInfoView()
            ProgressBar()
            MenuRows(MenueIcons: $MenueIcons, showProfile: $showProfile)
        }
        .menuBodyStyle()
        .overlay(
            Avatar().offset(y: -150))
        
        
        .alert(isPresented: $alertManager.showAlert) {
            Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
               }
    }
}

// MARK: - UserInfoView
struct UserInfoView: View {
    @EnvironmentObject var databaseService: DatabaseManager
    var body: some View {
        Text("\(databaseService.userName) - 25% complete")
            .font(.caption)
    }
}

// MARK: - MenuRows
struct MenuRows: View {
    @Binding var MenueIcons : [String: String]
    @Binding var showProfile: Bool
    @EnvironmentObject var databaseService: DatabaseManager
    @EnvironmentObject var alertManager: AlertManager
    @State private var showAccount : Bool = false
    @State private var showLogout : Bool = false
   
    
    
    func Logout (){
        databaseService.logoutUser { error in
            //Logout failed :
            if let error {
                self.alertManager.alertMessage  = "Error logging in: \(error.localizedDescription)"
                self.alertManager.showAlert = true
            } else {
               //Logout success :
                self.databaseService.isLogged = false // UPDATE
                print("Debug Logout : user is logged OUT ")
                //Render back to Home() and reset avatarView.
                self.showProfile = false
            }
                
        }
    }
    


    var body: some View {
        ForEach(MenueIcons.sorted(by: <), id: \.key) { key, value in
                Button {
                    // Trigger haptic feedback
                                   let generator = UIImpactFeedbackGenerator(style: .light)
                                   generator.prepare() // Prepare the generator
                                   generator.impactOccurred()
                    
                    
                    switch key {
                    case "Account":
                        showAccount = true
                    case "Sign Out":
                        showLogout = true
                    default:
                        break
                    }
                } label: {
                    MenuRow(title: " \(key)", icon: "\(value)")
                }
            }
            .alert("Are you sure you want to sign out?", isPresented: $showLogout) {
                Button("Sign Out", role: .destructive) {
                    Logout()
                }
                Button("Cancel", role: .cancel) { }
            }
            .sheet(isPresented: $showAccount) {
                AccountView() // Your AccountView here
            }
            .alert(isPresented: $alertManager.showAlert) {
                Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
            }
    }
}

// MARK: - View Modifiers
extension View {
    func menuBodyStyle() -> some View {
        self
            .frame(maxWidth: 500)
            .frame(height: 300)
            .background(.ultraThinMaterial)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [K.Colors.bkgColor3, K.Colors.bkgColor3.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
    }
}

// MARK: - Previews
#Preview {MenuBodyView(MenueIcons: ["Account": "gear"], showProfile: .constant(true))}
