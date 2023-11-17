//
//  ProgressBar.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/10/23.
//

import SwiftUI

struct ProgressBar: View {
    
    // MARK: - Body
    var body: some View {
        backgroundBar
            .overlay(progressBar)
            .padding()
          //  .frame(width: 150, height: 24)
            .background(backgroundBarColor)
            .cornerRadius(12)
            .shadow(color: shadowColor, radius: 0, x: 0, y: 1)
    }
}

// MARK: - Subviews
private extension ProgressBar {
    var backgroundBar: some View {
        Color.white
            .frame(width: 130, height: 6)
            .cornerRadius(3)
    }
    
    var progressBar: some View {
        LinearGradient(
            gradient: Gradient(colors: [progressBarColor1, progressBarColor2]),
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
        .frame(width: 60, height: 6)
        .cornerRadius(3)
    }
}

// MARK: - Colors
private extension ProgressBar {
    var progressBarColor1: Color { Color(red: 130/255, green: 244/255, blue: 177/255) }
    var progressBarColor2: Color { Color(red: 48/255, green: 198/255, blue: 124/255) }
    var backgroundBarColor: Color { Color(red: 0.8, green: 0.7725, blue: 0.7255) }
    var shadowColor: Color { Color(red: 0.8, green: 0.7725, blue: 0.7255) }
}

// MARK: - Preview

#Preview {
    ProgressBar()
}
  
 
