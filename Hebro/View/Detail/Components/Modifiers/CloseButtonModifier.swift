//
//  CloseButtonModifier.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//
import SwiftUI

struct CloseButtonModifier: ViewModifier {
    @Binding var show: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.show = false
                        }) {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        .padding()
                    }
                    Spacer()
                }, alignment: .topTrailing
            )
    }
}

extension View {
    func closeButton(show: Binding<Bool>) -> some View {
        self.modifier(CloseButtonModifier(show: show))
    }
}

