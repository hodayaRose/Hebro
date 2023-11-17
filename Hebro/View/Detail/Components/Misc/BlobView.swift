//
//  BlobView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/7/23.
//

import SwiftUI
struct BlobView: View {
    @Binding var showBulb: Bool
    var offsetValue: CGSize
    var rotationStart: Double
    var rotationEnd: Double
    
    var body: some View {
        Image(uiImage: #imageLiteral(resourceName: "Blob"))
            .opacity(0.4)
            .offset(x: offsetValue.width, y: offsetValue.height)
            .rotationEffect(Angle(degrees: showBulb ? rotationEnd : rotationStart))
            .animation(.linear(duration: 120).repeatForever(autoreverses: false), value: showBulb)
            .onAppear { self.showBulb = true }
    }
}

