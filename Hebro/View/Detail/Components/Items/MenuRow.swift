//
//  MenuRow.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/1/23.
//

///a row contains the icone and text of Menu

import SwiftUI

// MARK: - MenuRow View
struct MenuRow: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack(spacing: 5) {
            
            iconImage
            titleText
        }
        .menuRowStyle()
    }
    
    private var iconImage: some View {
        Image(systemName: icon)
            .font(.system(size: 20, weight: .light))
            .imageScale(.large)
            .frame(width: 32, height: 32)
            .foregroundColor(Color.menuRowIconColor.opacity(0.6))
    }
    
    private var titleText: some View {
        Text(title)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .menuRowTextShadow()
            .frame(width: 120, alignment: .leading)
            .foregroundColor(.black)
    }
}

// MARK: - View Modifiers
extension View {
    func menuRowStyle() -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal, 20)
            .padding(.all, 2)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.menuRowStrokeColor.opacity(0.8), lineWidth: 0.5)
                    .shadow(color: Color.menuRowShadowColor, radius: 0, x: 0, y: 1)
            )
    }
    
    func menuRowTextShadow() -> some View {
        self
            .shadow(color: Color.menuRowTextShadowColor.opacity(0.5), radius: 0, x: 0, y: 0)
    }
}

// MARK: - Color Extension
extension Color {
    static let menuRowIconColor = Color(red: 0.5176, green: 0.4588, blue: 0.4667)
    static let menuRowStrokeColor = Color(red: 0.5176, green: 0.4588, blue: 0.4667)
    static let menuRowShadowColor = Color(red: 0.8, green: 0.7725, blue: 0.7255)
    static let menuRowTextShadowColor = Color(red: 0.8, green: 0.7725, blue: 0.7255)
}

