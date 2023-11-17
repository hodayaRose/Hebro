//
//  BackgroundColor.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI
///the background color in courseList.Swift view 
struct BackgroundColor: View {
    @Binding var activeView : CGSize
    var body: some View {
        Color.black.opacity(Double(self.activeView.height/500))
            .animation(.linear)
            .edgesIgnoringSafeArea(.all)
    }
}
