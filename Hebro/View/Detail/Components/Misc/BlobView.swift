//
//  BlobView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/7/23.
//

import SwiftUI
struct BlobView: View {
    @Binding var show: Bool
    var offsetValue: CGSize
    var rotationStart: Double
    var rotationEnd: Double
    
    var body: some View {
        Image(uiImage: #imageLiteral(resourceName: "Blob"))
            .offset(x: offsetValue.width, y: offsetValue.height)
            .rotationEffect(Angle(degrees: show ? rotationEnd : rotationStart))
            .animation(.linear(duration: 120).repeatForever(autoreverses: false), value: show)
            .onAppear { self.show = true }
    }
}

