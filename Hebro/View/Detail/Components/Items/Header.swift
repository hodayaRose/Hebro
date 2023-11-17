//
//  Header.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI
///the Header component in HomeView
struct Header: View {
    @Binding var showProfile: Bool
    @Binding var showUpdate: Bool
    
    @EnvironmentObject var notificationManager: NotificationManager // Assuming you have a notification manager
    
    var body: some View {
        HStack {
            /// Title and eyeglasses icon
            HStack {
                Text("Learning")
                    .font(.title)
                    .fontWeight(.bold)
                Image(systemName: "eyeglasses")
                    .fontWeight(.bold).font(.title)
            }
            
            Spacer()
            HStack(spacing: 12) {
                
                /// Profile view / Login button
                AvatarView(showProfile: $showProfile)
                
                /// Notification button
                Button(action: { self.showUpdate.toggle() }) {
                    FeatureButton(name: "bell")
                        .foregroundColor(.primary)
                }
                /// Display the updates list when the button is tapped
                .sheet(isPresented: $showUpdate) {
                    UpdateList(notificationManager: notificationManager)
                }
            }
        }
       
        .padding(.horizontal,25)
        .padding(.leading, 14)
        .padding(.top, 30)
    
    }
}
