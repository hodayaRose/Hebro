//
//  SuccessView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/31/23.
//
//This view will be displayed when user presed the login button in the LoginView
import SwiftUI

struct SuccessView: View {
    @State var show = false
    
    var body: some View {
        VStack {
            Text("Logging you...")
                .font(.title).bold()
                .opacity(show ? 1 : 0)
                .animation(Animation.linear(duration: 1).delay(0.2),value: show)
            //loads the lottie animation
            LottieView(lottieFile: K.lottieFile.success)
                .frame(width: 300, height: 300)
                .opacity(show ? 1 : 0)
                .animation(.linear(duration: 1).delay(0.4),value: show)
        }
        .padding(.top, 30)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0),value: show)
        .onAppear {
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.5 : 0))
        .animation(.linear(duration: 0.5),value: show)
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    SuccessView(show:true)
//}

