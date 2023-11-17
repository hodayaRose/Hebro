//
//  WatchringsView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

import SwiftUI

// MARK: - WatchringsView
struct WatchringsView: View {
    @State var colors = [UIColor(red: 255/255, green: 95/255, blue: 109/255, alpha: 1),
                         UIColor(red: 255/255, green: 195/255, blue: 113/255, alpha: 1),
                         UIColor(red: 0.5098, green: 0.9569, blue: 0.6941, alpha: 1.0),
                         UIColor(red: 0.1882, green: 0.7765, blue: 0.4863, alpha: 1.0),
                         UIColor(red: 0.9843, green: 0.8157, blue: 0.4863, alpha: 1.0),
                         UIColor(red: 0.9686, green: 0.9686, blue: 0.4745, alpha: 1.0)]
    var body: some View {
        HStack(spacing: 30) {
            RingSection(color1: colors[0],color2: colors[1] ,width: 44, height: 44, percent: 68, label: ("6 minutes left", "Tap to reveal your Certificate"))
            RingSection(color1: colors[2],color2: colors[3],width: 32, height: 32, percent: 54)
            RingSection(color1: colors[4],color2: colors[5],width: 32, height: 32, percent: 23)
        }
    }
}

// MARK: - RingSection View
struct RingSection: View {
    var color1: UIColor
    var color2: UIColor
    var width: CGFloat
    var height: CGFloat
    var percent: CGFloat
    var label: (title: String, subtitle: String)?
    
    init(color1: UIColor = .clear, color2: UIColor = .clear, width: CGFloat, height: CGFloat, percent: CGFloat, label: (title: String, subtitle: String)? = nil) {
        self.color1 = color1
        self.color2 = color2
        self.width = width
        self.height = height
        self.percent = percent
        self.label = label
    }
    
    var body: some View {
        HStack(spacing: 12) {
            RingView(color1: color1, color2: color2, width: width, height: height, percent: percent, show: .constant(true))
            if let label = label {
                VStack(alignment: .leading, spacing: 4) {
                    Text(label.title).bold().modifier(FontModifierRing(style: .subheadline))
                    Text(label.subtitle).modifier(FontModifierRing(style: .caption))
                }
            }
        }
        .padding(8)
        .background(K.Colors.bkgColor3)
        .cornerRadius(20)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .modifier(ShadowModifierRing())
    }
}

// MARK: - FontModifierRing
struct FontModifierRing: ViewModifier {
    var style: Font.TextStyle = .body
    func body(content: Content) -> some View {
        content
            .font(.system(style, design: .default))
    }
}

// MARK: - ShadowModifierRing
struct ShadowModifierRing: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
    }
}

// MARK: - Previews
#Preview {
    WatchringsView()
}
