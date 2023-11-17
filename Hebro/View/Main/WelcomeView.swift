//
//  WelcomeView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/13/23.
//


//import SwiftUI
//
//struct WelcomeView: View {
//    @State private var name: String = ""
//    @State private var age: String = ""
//    @State private var email: String = ""
//    @State private var password: String = ""
//   // @State private var isPresentingHomeView: Bool = false
//    @State private var selectedAvatarScale: CGFloat = 1.0
//    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
//    @EnvironmentObject var alertManager: AlertManager
//    @EnvironmentObject var databaseService: DatabaseManager
//
//    var body: some View {
//   
//        GeometryReader { geometry in
//            ZStack {
//                Home()
//                    .conditionalBlur(radius: welcomeViewManager.isPresentingHomeView ? 0 : 5)
//                    .overlay(
//                        welcomeViewManager.isPresentingHomeView ? AnyView(Color.clear) : AnyView(Color.clear.onTapGesture { })
//                    )
//
//
//                if !welcomeViewManager.isPresentingHomeView {
//                    WelcomeContentView(name: $name, age: $age, email: $email, password: $password, selectedAvatarScale: $selectedAvatarScale )
//                        .background(Color.black.opacity(0.5))
//                        
//                        .alert(isPresented: $alertManager.showAlert) {
//                            Alert(title: Text("Error"), message: Text(alertManager.alertMessage), dismissButton: .default(Text("OK")))
//                        }
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight:.infinity) // Use the geometry to set the frame
//            .edgesIgnoringSafeArea(.all)
//        }
//        
//    }
//}
//
//// MARK: - WelcomeContentView
//struct WelcomeContentView: View {
//    @Binding var name: String
//    @Binding var age: String
//    @Binding var email: String
//    @Binding var password: String
//    @State var isFocused = false
//    @Binding var selectedAvatarScale: CGFloat
// 
//    @EnvironmentObject var databaseService : DatabaseManager
//    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
//    @EnvironmentObject var alertManager: AlertManager
//
//    var body: some View {
//        GeometryReader { geometry in
//            VStack {
//                RoundedRectangle(cornerRadius: 35.0)
//                    .fill(Color.white.opacity(0.8))
//                    .padding(.top,85)
//                    .padding(.bottom,100)
//                
//                
//                    .overlay(
//                        VStack {
//                            Text("Welcome to Hebro")
//                                .font(.title)
//                                .offset(y:-50)
//
//                            AvatarScrollComponent(selectedAvatarScale: $selectedAvatarScale)
//
//                            VStack(spacing: 2) {
//                                TextFieldComponent(placeholder: "Name", text: $name)
//                                TextFieldComponent(placeholder: "Age", text: $age)
//                                TextFieldComponent(placeholder: "Email", text: $email)
//                                TextFieldComponent(placeholder: "Password", text: $password, isSecure: true)
//                            }
//                            .animation(.easeInOut ,value: isFocused)
//                            .onTapGesture {
//                                self.isFocused = true
//                                hideKeyboard()
//                            }
//                            .padding()
//                           // .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
//                            .background(.thinMaterial)
//                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                            .shadow(color: Color.black.opacity(0.15), radius: 20, x: 0, y: 20)
//                          //  .padding(.horizontal)
//                           // .offset(y: isFocused ? -geometry.size.height * 0.2 : geometry.size.height * 0.2)
//                            
//                            Button("Submit") {
//                                welcomeViewManager.submit(name: name, age: age, email: email, password: password)
//                                //self.isPresentingHomeView = true
//                            }
//                            .padding(15)
//                            .padding(.horizontal, 30)
//                            .foregroundColor(.black)
//                            .background(.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                            .shadow(color: Color.white.opacity(0.3), radius: 20, x: 0, y: 20)
//                            .offset(y: 15)
//                        }
//                        .padding()
//                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .center)
//                        .edgesIgnoringSafeArea(.all)
//                    )
//            }
//        
//            
//            .padding()
//       
//        }
//    }
//}
//
//
//
//struct AvatarScrollComponent: View {
//    @Binding var selectedAvatarScale: CGFloat
//    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
//    @EnvironmentObject var databaseService : DatabaseManager
//
//    var body: some View {
//        ZStack {
//            avatarScrollView
//        }
//    }
//
//    var avatarScrollView: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(1..<3) { index in
//                    avatarImage(for: index)
//                }
//            }
//        }
//    }
//
//    func avatarImage(for index: Int) -> some View {
//        Image("Avatar\(index)")
//            .resizable()
//            .frame(width: 30, height: 30)
//            .padding()
//            
//            .scaleEffect(index == welcomeViewManager.avatarIndex ? selectedAvatarScale : 1.0)
//            
//            .background(welcomeViewManager.avatarIndex == index ? K.Colors.bkgColor2 : Color.clear)
//            .clipShape(RoundedRectangle(cornerRadius: 25))
//            .onTapGesture {
//                welcomeViewManager.avatarIndex = index
//                print(welcomeViewManager.avatarIndex)
//                withAnimation(.easeInOut(duration: 0.2)) {
//                    selectedAvatarScale = 1.2
//                    
//                    
//                }
//                withAnimation(Animation.easeInOut(duration: 0.2).delay(0.1)) {
//                    selectedAvatarScale = 1.0
//                }
//            }
//    }
//}
//
// 
//
//
//func hideKeyboard() {
//    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//}
import SwiftUI

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
