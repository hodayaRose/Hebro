//
//  Avatar.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/10/23.
//

import SwiftUI

struct Avatar: View {
    @EnvironmentObject var welcomViewManager : WelcomeViewManager
    var body: some View {
        ZStack{
            Image("Avatar\(welcomViewManager.avatarIndex)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 40,height: 40)
                .clipShape(Circle())
            
        }
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}
