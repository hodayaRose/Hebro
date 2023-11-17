//
//  UpdateButton.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/11/23.
//

import SwiftUI

//the button component that is used for the loginView and the  Updateview
struct FeatureButton: View {
    @State var name : String
    var body: some View {
        Image(systemName: name)
        
            .renderingMode(.original)
            .foregroundColor(K.Colors.primery)
            .font(.system(size: 16, weight: .medium))
            .frame(width: 36, height: 36)
            .background(K.Colors.bkgColor3)
            .clipShape(Circle())
            .shadow(color: K.Colors.primery.opacity(0.1), radius: 1, x: 0, y: 1)
            .shadow(color:  K.Colors.primery.opacity(0.2), radius: 10, x: 0, y: 10)
    }
}

#Preview {
    FeatureButton(name: "Avatar")
}

