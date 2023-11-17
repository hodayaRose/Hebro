//
//  UpdateList.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//

import SwiftUI
//this view is the update list view that renders when user press update "bell" botton in homeView

struct UpdateList: View {
    @ObservedObject var notificationManager : NotificationManager
    
    //adds an update to Updates view
    
    
    var body: some View {
        
        NavigationView {
            
            List{
                
                //foreach update in updates array create an updatCell
                ForEach(notificationManager.updates) { update  in
                    NavigationLink(destination: UpdateDetail( dataSource: notificationManager, update: update)) {
                        // a single update call conponet
                        CellUpdate(image: update.image, title: update.title, text: update.text, date: update .date)
                            .padding(.vertical, 8)
                    }
                }
                //removes an update from list
                .onDelete { index in
                    if let firstIndex = index.first{
                        self.notificationManager.removeUpdate(firstIndex: firstIndex)
                    }
                }
                //allows user to rearange updates on list
                .onMove{(source: IndexSet, destination:Int) in
                    self.notificationManager.updates.move(fromOffsets: source, toOffset: destination)
                }
            }
            .navigationTitle(Text("Word Of The Day")
            )
            
            
            
            //add update button
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // when updtae button is pressed addUpdate is being called
                    Button(action:
                            self.notificationManager.addUpdate) {
                        Image(systemName: "arrow.clockwise.circle")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
            }
            
        }
        
    }
}

#Preview{
    UpdateList(notificationManager: NotificationManager())
}


