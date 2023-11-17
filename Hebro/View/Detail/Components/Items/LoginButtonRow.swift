//
//  LoginButtonRow.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI

// Define a custom View for the Forgot Password and Login buttons
struct LoginButtonRow: View {
    
    var onLogin: () -> Void
    @EnvironmentObject var alertManager : AlertManager

    var body: some View {
        HStack {
            Text("Forgot password?")
                .font(.subheadline)
                .onTapGesture {
                    print("forgot password tapped")
                }
            
            Spacer()
            
            Button(action: {
                onLogin()
            }) {
                Text("Log in").foregroundColor(.black)
            }
            .loginButtonStyle()
            .alert(isPresented: $alertManager.showAlert) {
                Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

// Define the style extension on View for the login button
extension View {
    func loginButtonStyle() -> some View {
        self
            .padding(15)
            .padding(.horizontal, 30)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

