//
//  HomeBackgroundView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI

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
