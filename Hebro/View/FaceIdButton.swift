//
//  FaceIdButton.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

import SwiftUI

struct FaceIdButton: View {
    var image: String?
    var showImage = true
    var text: String
    
    var body: some View {
        HStack (spacing: 15  ){
            if showImage {
                Image(systemName: image ?? "person.fill")
                    .frame(width: 44, height: 44)
                    .background(Color("background1"))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
            
            }
            
            Text(text)
        }
        .padding()
        .padding(.horizontal)
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        FaceIdButton(image: "faceid", text: "Login with FaceID")
    }
}
