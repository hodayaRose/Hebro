//
//  UpdateDetail.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//

//import SwiftUI
//import SDWebImageSwiftUI
//
//
//struct UpdateDetail: View {
//    @ObservedObject var dataSource: DataSource
//    
//    var update: Update
//    
//    var body: some View {
//        List {
//            VStack(spacing: 20) {
//                
//                Image(systemName:update.image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .foregroundColor(.black)
//                    .frame(maxWidth: .infinity)
//                    .imageScale(.large)
//                    .edgesIgnoringSafeArea(.all)
//                
//                Text(update.text)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .fontWeight(.bold)
//                    .padding(.bottom,10)
//            }
//            
//        }
//        .navigationBarTitle(update.title)
//        .listStyle(PlainListStyle())
//    }
//}
//
//
//
import SwiftUI
import SDWebImageSwiftUI

struct UpdateDetail: View {
    @ObservedObject var dataSource: NotificationManager
     @State var update: Update
    
    var body: some View {
        List {
            content
        }
        .listStyle(PlainListStyle())
        .navigationBarTitle(update.title)
    }
    
    private var content: some View {
        VStack(spacing: 20) {
            image
            text
        }
    }
    
    private var image: some View {
        Image(systemName: update.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .imageScale(.large)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var text: some View {
        Text(update.text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.bold)
            .padding(.bottom, 10)
    }
}
