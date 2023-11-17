//
//  TapBar.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//

import SwiftUI
/// not used in this app
struct TabBar: View {
    @EnvironmentObject var databaseService : DatabaseManager
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            CourseList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
        }

    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
      
//            TabBar().previewDevice("iPhone 8")
            TabBar()
            .environmentObject(DatabaseManager())
        
    }
}

