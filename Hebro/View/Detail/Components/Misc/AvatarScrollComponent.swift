//
//  AvatarScrollComponent.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/2/23.
//

import SwiftUI

struct AvatarScrollComponent: View {
    @Binding var selectedAvatarScale: CGFloat
    @EnvironmentObject var welcomeViewManager: WelcomeViewManager
    @EnvironmentObject var databaseService : DatabaseManager

    var body: some View {
        avatarScrollView
    }

    private var avatarScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1..<3) { index in
                    avatarImage(for: index)
                }
            }
        }
    }

    private func avatarImage(for index: Int) -> some View {
        Image("Avatar\(index)")
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .scaleEffect(index == welcomeViewManager.avatarIndex ? selectedAvatarScale : 1.0)
            .background(welcomeViewManager.avatarIndex == index ? K.Colors.bkgColor2 : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .onTapGesture {
                welcomeViewManager.avatarIndex = index
                print(welcomeViewManager.avatarIndex)
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedAvatarScale = 1.2
                }
                withAnimation(Animation.easeInOut(duration: 0.2).delay(0.1)) {
                    selectedAvatarScale = 1.0
                }
            }
    }
}

