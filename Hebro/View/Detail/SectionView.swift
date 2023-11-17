//
//  SectionView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

import SwiftUI

// MARK: - SectionView
struct SectionView: View {
    var section: SectionModel
    var width: CGFloat = 275
    var height: CGFloat = 275
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionHeaderView(section: section)
            SectionTextView(section: section)
            SectionImageView(section: section)
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: width, height: height)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3), radius: 20, x: 0, y: 20)
    }
}

// MARK: - SectionHeaderView
struct SectionHeaderView: View {
    var section: SectionModel
    
    var body: some View {
        HStack {
            Text(section.title)
                .modifier(SectionTitleModifier())
                .frame(width: 160, alignment: .leading)
            
            Spacer()
            Image(section.logo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40, height: 40)
        }
    }
}

// MARK: - SectionTextView
struct SectionTextView: View {
    var section: SectionModel
    
    var body: some View {
        Text(section.text.uppercased())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - SectionImageView
struct SectionImageView: View {
    var section: SectionModel
    
    var body: some View {
        section.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 210)
    }
}

// MARK: - SectionTitleModifier
struct SectionTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.system(size: 24))
            .fontWeight(.bold)
            .lineLimit(3)
    }
}

