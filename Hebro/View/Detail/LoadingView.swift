//
//  LoadingView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/31/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            //loads the lottie animation 
            LottieView(lottieFile: K.lottieFile.loading )
                .frame(width: 200, height: 200)
        }
    }
}

#Preview {
    LoadingView()
}


