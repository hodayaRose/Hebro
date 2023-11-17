//
//  WelcomeViewComponent.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/15/23.
//

import SwiftUI

// MARK: - TextFieldComponent View
struct TextFieldComponent: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        if isSecure {
            SecureField(placeholder, text: $text).textFieldStyle()
        } else {
            TextField(placeholder, text: $text).textFieldStyle()
        }
    }
}

// MARK: - View Styling Extensions
extension View {
    func textFieldStyle() -> some View {
        self
            .padding(.horizontal, 20)
            .frame(height: 40)
            .background(RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 0.8))
            .padding(.vertical, 5)
    }
    
    func conditionalBlur(radius: CGFloat) -> some View {
        if radius > 0 {
            return AnyView(self.blur(radius: radius))
        } else {
            return AnyView(self)
        }
    }
}
