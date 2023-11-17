//
//  Modifiers.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//

import SwiftUI

struct BackgroundStyle: ViewModifier {
    var cornerRadius: CGFloat = 20
    var opacity: Double = 0.6
    @AppStorage("isLiteMode") var isLiteMode = true
    
    func body(content: Content) -> some View {
        content
          //  .backgroundColor(opacity: opacity)
            .cornerRadius(cornerRadius)
            .shadow(color: Color("Shadow").opacity(isLiteMode ? 0 : 0.3), radius: 20, x: 0, y: 10)
            .modifier(OutlineOverlay(cornerRadius: cornerRadius))
    }
}

extension View {
    func backgroundStyle(cornerRadius: CGFloat = 20, opacity: Double = 0.6) -> some View {
        self.modifier(BackgroundStyle(cornerRadius: cornerRadius, opacity: opacity))
    }
}
//extension View {
//    func backgroundColor(opacity: Double = 0.6) -> some View {
//        self.modifier(BackgroundColor(opacity: opacity))
//    }
//}

struct OutlineOverlay: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat = 20
    
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(
                    .linearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                            .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .blendMode(.overlay)
        )
    }
}
struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

struct FontModifier: ViewModifier {
    var style: Font.TextStyle = .body
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
            
           
    }
}
struct CustomFontModifier: ViewModifier {
    var size : CGFloat = 28
    func body(content: Content) -> some View {
        content
            .font(.custom("Raleway-ExtraBold.ttf",  size: size))
    }
}

//view functions



 
//dinamic card width adjusment
func getCardWidth(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width > 712 {
        return 712
    }
    
    return bounds.size.width - 60
}
//dinamic card radius adjusment
func getCardCornerRadius(bounds: GeometryProxy) -> CGFloat {
    if bounds.size.width < 712 && bounds.safeAreaInsets.top < 44 {
        return 0
    }
    
    return 30
}


//replace angle in sectionView AJGUSMENT to ipad
func getAngleMultiplier(bounds: GeometryProxy) -> Double {
    
    if bounds.size.width > 500 {
        return 80
    } else {
        return 20
    }
}

