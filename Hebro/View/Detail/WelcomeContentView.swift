//
//  WelcomeContentView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/2/23.
//

import SwiftUI

struct WelcomeContentView: View {
    @Binding var name: String
    @Binding var age: String
    @Binding var email: String
    @Binding var password: String
    @State var isFocused = false
    @Binding var selectedAvatarScale: CGFloat
    @EnvironmentObject var databaseService : DatabaseManager
    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
    @EnvironmentObject var alertManager: AlertManager

    var body: some View {
        GeometryReader { geometry in
            VStack {
                contentOverlay
                    .padding()
            }
            .padding()
        }
    }
    
    private var contentOverlay: some View {
        RoundedRectangle(cornerRadius: 35.0)
            .fill(Color.white.opacity(0.8))
            .padding(.top,85)
            .padding(.bottom,100)
            .overlay(
                VStack {
                    header
                    AvatarScrollComponent(selectedAvatarScale: $selectedAvatarScale)
                    inputFields
                    submitButton
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .edgesIgnoringSafeArea(.all)
            )
    }
    
    private var header: some View {
        Text("Welcome to Hebro")
            .font(.title)
            .offset(y:-50)
    }
    
    private var inputFields: some View {
        VStack(spacing: 2) {
            TextFieldComponent(placeholder: "Name", text: $name)
            TextFieldComponent(placeholder: "Age", text: $age)
            TextFieldComponent(placeholder: "Email", text: $email)
            TextFieldComponent(placeholder: "Password", text: $password, isSecure: true)
        }
        .animation(.easeInOut, value: isFocused)
        .onTapGesture {
            self.isFocused = true
            hideKeyboard()
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
    }
    
    private var submitButton: some View {
        Button("Submit") {
            welcomeViewManager.submit(name: name, age: age, email: email, password: password)
        }
        .padding(15)
        .padding(.horizontal, 30)
        .foregroundColor(.black)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.white.opacity(0.3), radius: 20, x: 0, y: 20)
        .offset(y: 15)
    }
}
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
