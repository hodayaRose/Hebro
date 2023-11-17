//
//  CellUpdate.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/13/23.
//

import SwiftUI

struct CellUpdate: View {
    @State var image : String
    @State var title : String
    @State var text : String
    @State var date : String
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(15)
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(20)
                .padding(.trailing, 4)
                .imageScale(.small)
                
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                
                Text(text)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                
                Text(date)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    CellUpdate(image: "Avatar", title: "hello", text: "hey", date: "23/3")
}
