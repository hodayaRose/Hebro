//
//  Home.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/24/23.
//
//Purpose: The Home view appears to be the main container view for your application. It manages the overall layout, background, and additional views such as profile, menu, login, and content views.
import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    
    @EnvironmentObject var databaseService : DatabaseManager
    
    var body: some View {
        ZStack {
            K.Colors.bkgColor2//"homeBackground"
                .edgesIgnoringSafeArea(.all)
            HomeBackgroundView(showProfile: $showProfile)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0),value: showProfile)
                .edgesIgnoringSafeArea(.all)

                
            HomeViewController(showProfile: $showProfile , showContent: $showContent, viewState: $viewState)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0),value: showProfile)
                .edgesIgnoringSafeArea(.all)
                    
            
            MenuViewController(showProfile: $showProfile)
                .background(Color.black.opacity(0.001))
                .offset(y: self.viewState.height)
                .offset(y: showProfile ? 0 : screen.height)
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture().onChanged { value in
                        self.viewState = value.translation
                    }
                        .onEnded { value in
                            if self.viewState.height > 50 {
                                self.showProfile = false
                            }
                            self.viewState = .zero
                        }
                )
            
            
            //if avatar icon pressed it natigates to LoginView
            if databaseService.showLogin {
                ZStack {
                    LoginView()
                    
                    //x button
                    VStack {
                        HStack {
                            Spacer()
                            
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                    }
                    .padding()
                    //tap gesture to  close the loginView
                    .onTapGesture {
                        self.databaseService.showLogin = false
                            
                            
                    }
                    
                }
                
            }
            //if "tap to reveal certificate" button is pressed it shows the certificate view
            if showContent {
                //white background
                //  Color.white
                Rectangle()
                    .fill(.thinMaterial)
                    .edgesIgnoringSafeArea(.all)
                CertificateView()
                //x button
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding()
                //tap to close view
                .onTapGesture {
                    self.showContent = false
                        
                        
                }
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0),value: showContent)
                .transition(.move(edge: .top))
                
               
                    
               
               
                 
                
            }
            
        }
      
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        //    Home().environment(\.colorScheme,.dark)
        Home()
            .environmentObject(DatabaseManager())
       
    }
}


//get screen size
let screen = UIScreen.main.bounds

struct HomeBackgroundView: View {
    @Binding var showProfile: Bool
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [K.Colors.bkgColor2, K.Colors.bkgColor1]), startPoint: .top, endPoint: .bottom)
                .frame(height: 200)
            Spacer()
        }
        .background(K.Colors.bkgColor1)
        .clipShape(RoundedRectangle(cornerRadius: showProfile ? 30 : 0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
    }
}
