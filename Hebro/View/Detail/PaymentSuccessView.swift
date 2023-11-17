//
//  PaymentSuccessView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/9/23.
//

//This view is displayed when course is purchased and payment succeed

import SwiftUI
struct PaymentSuccessView: View {
    @EnvironmentObject var paymentManager: PaymentManager
    
    
    // Computed property to determine whether to show the success view
    @State var showSuccessView: Bool=false
    
    var body: some View {
        ZStack {
            ScrollView {
                if paymentManager.paymentSuccess {
                    
                    ZStack {
                   SuccessView()
                        
                        //x button
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "xmark")
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(.white)
                                    .background(.black)
                                    .clipShape(Circle())
                            }
                            .padding(.top, 16)
                            .padding(.trailing, 16)
                            
                            Spacer()
                        }
                        .padding()
                        //tap gesture to open/ close the loginView
                            .onTapGesture {
                                self.showSuccessView = false
                            }
                }
                    .padding(.top, 30)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .onAppear{
                        self.showSuccessView = true
                    }
                }
                
            }
            .onDisappear {
                if paymentManager.paymentSuccess {
                    paymentManager.paymentSuccess = false
                }
                
                
            }
            

        }
    }
}

struct PaymentSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentSuccessView()
            .environmentObject(PaymentManager())
    }
}


