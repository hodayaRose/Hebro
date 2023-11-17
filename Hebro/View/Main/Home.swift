//
//  Home.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/24/23.
//
//Purpose: The Home view appears to be the container view for HomeView . It manages the overall layout, background, and additional views such as profile, menu, login, and content views.
import SwiftUI

struct Home: View {
    
    @State private var showProfile = false
    @State private var viewState = CGSize.zero
    @State private var showContent = false
    
    @EnvironmentObject var databaseService : DatabaseManager
    
    var body: some View {
        ZStack {
            K.Colors.bkgColor2///"homeBackground"
                .edgesIgnoringSafeArea(.all)
            HomeBackgroundView(showProfile: $showProfile)
                .homeViewModifiers(showProfile: $showProfile, viewState: viewState)
            
            
            
            HomeView(showProfile: $showProfile , showContent: $showContent, viewState: $viewState)
                .homeViewModifiers(showProfile: $showProfile, viewState: viewState)
            
            
            MenuViewController(showProfile: $showProfile)
                .menuViewModifiers(showProfile: $showProfile, viewState: $viewState, screen: UIScreen.main.bounds.size)
            
            
            
            //if avatar icon pressed it navigates to LoginView()
            if databaseService.showLogin {
                ZStack {
                    LoginView()
                        .closeButton(show: $databaseService.showLogin)
                        
                }
            }
            //if "tap to reveal certificate" button is pressed it shows the certificate view
            if showContent {
                Rectangle()
                    .fill(.thinMaterial)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0), value: showContent)
                    .transition(.move(edge: .top))
                
                CertificateView()
                    .closeButton(show: $showContent) // Use the custom CloseButtonModifier
            }
            
        }
        
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        
        Home()
            .environmentObject(DatabaseManager())
        
    }
}


//get screen size
let screen = UIScreen.main.bounds
///homeViewModifiers
extension View {
    func homeViewModifiers(showProfile: Binding<Bool>, viewState: CGSize) -> some View {
        self
            .offset(y: showProfile.wrappedValue ? -450 : 0)
            .rotation3DEffect(
                Angle(degrees: showProfile.wrappedValue ? Double(viewState.height / 10) - 10 : 0),
                axis: (x: 10.0, y: 0, z: 0)
            )
            .scaleEffect(showProfile.wrappedValue ? 0.9 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0), value: showProfile.wrappedValue)
            .edgesIgnoringSafeArea(.all)
    }
}
///menuViewModifiers
extension View {
    func menuViewModifiers(showProfile: Binding<Bool>, viewState: Binding<CGSize>, screen: CGSize) -> some View {
        self
            .background(Color.black.opacity(0.001))
            .offset(y: viewState.wrappedValue.height)
            .offset(y: showProfile.wrappedValue ? 0 : screen.height)
            .onTapGesture {
                showProfile.wrappedValue.toggle()
            }
            .gesture(
                DragGesture().onChanged { value in
                    viewState.wrappedValue = value.translation
                }
                    .onEnded { value in
                        if viewState.wrappedValue.height > 50 {
                            showProfile.wrappedValue = false
                        }
                        viewState.wrappedValue = .zero
                    }
            )
    }
}
