//
//  LottieView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/31/23.
//





import SwiftUI
import Lottie
import Foundation

struct LottieView: UIViewRepresentable {
   typealias UIViewType = UIView
    var lottieFile: String
     var loopMode: LottieLoopMode = .playOnce
     var animationView = LottieAnimationView()
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
             
             animationView.animation = LottieAnimation.named(lottieFile)
             animationView.contentMode = .scaleAspectFill
             animationView.loopMode = loopMode
             
             animationView.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(animationView)
        
       NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}


