//
//  XButton.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/10/23.
//

import SwiftUI

struct XButton: View {
    var body: some View {
        //x button
        VStack {
            HStack {
               
                    Image(systemName: "xmark")
                        .frame(width: 36, height: 36)
                        .foregroundColor(.white)
                        .background(.black)
                        .clipShape(Circle())
                }
                .padding(.top,20)
                .padding(.horizontal,30)
                //.offset(y: self.isLandscape ? 25 : 25)
                Spacer()
            }
            Spacer()
        
        
        
    }}


#Preview {
    XButton()
}
