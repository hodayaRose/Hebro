//
//  LoginInputComponent.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI

struct LoginInputComponent: View {
    @Binding var email : String
    @Binding var password : String
    @Binding var isFocused : Bool
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                    .frame(width: 44, height: 44)
                    .background(K.Colors.bkgColor1)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                TextField("Your Email".uppercased(), text: $email)
                    .keyboardType(.emailAddress)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: 44)
                    .onTapGesture {
                        self.isFocused = true
                    }
            }
            
            Divider().padding(.leading, 80)
            
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                    .frame(width: 44, height: 44)
                    .background(K.Colors.bkgColor1)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 5)
                    .padding(.leading)
                
                SecureField("Password".uppercased(), text: $password)
                    .keyboardType(.default)
                    .font(.subheadline)
                    .padding(.leading)
                    .frame(height: 44)
                    .onTapGesture {
                       
                        self.isFocused = true
                       
                    }
            }
        }
    }
}

#Preview {
    LoginInputComponent(email: .constant("gmail@gmail.com"), password: .constant("123"), isFocused: .constant(false))
}
