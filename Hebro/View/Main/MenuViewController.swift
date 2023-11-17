//
//  MenuView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/24/23.
//

import SwiftUI

struct MenuViewController: View {
    @EnvironmentObject var dataSource : NotificationManager
    @EnvironmentObject var databaseService : DatabaseManager
    @Binding var showProfile: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            MenuBodyView(showProfile: $showProfile)
        }
        .padding(.bottom, 30)
    }
}

struct MenuViewController_Previews: PreviewProvider {
    static var previews: some View {
        MenuViewController(showProfile:.constant(true))
            .environmentObject(DatabaseManager())
            .environmentObject(NotificationManager())
        
    }
}



