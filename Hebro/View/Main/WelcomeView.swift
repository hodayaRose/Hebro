//
//  WelcomeView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/13/23.
//



import SwiftUI
///welcome view is the initial view only if its the first time you've lunched the app, its responsible for user registration to app.
struct WelcomeView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedAvatarScale: CGFloat = 1.0
    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
    @EnvironmentObject var alertManager: AlertManager
    @EnvironmentObject var databaseService: DatabaseManager

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Home()
                    .conditionalBlur(radius: welcomeViewManager.isPresentingHomeView ? 0 : 5)
                
                if !welcomeViewManager.isPresentingHomeView {
                    WelcomeContentView(name: $name, age: $age, email: $email, password: $password, selectedAvatarScale: $selectedAvatarScale)
                        .background(Color.black.opacity(0.5))
                        .alert(isPresented: $alertManager.showAlert) {
                            Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight:.infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
