//
//  CourseShopTitleView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI
///displayed in homeView
struct CourseShopTitleView: View {
    var body: some View {
        HStack {
            Text("Courses Shop")
                .font(.title)
                .fontWeight(.bold)
            
            Image(systemName: K.Images.bag)
                .fontWeight(.bold)
                .font(.title)
            
            Spacer()
        }
        .padding(.bottom, 25)
        .padding(.leading, 30)
        .offset(y: -60)
    }
}

