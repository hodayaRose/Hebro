//
//  CoverView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/15/23.
//

import SwiftUI

struct CoverView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    
    var body: some View {
        VStack {
            TitleCoverView(viewState: $viewState)
            
            DescriptionText(viewState: $viewState)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .edgesIgnoringSafeArea(.top)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            BackgroundView(show: $show, viewState: $viewState)
        )
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3"))
                .offset(x: viewState.width/25, y: viewState.height/25),
            alignment: .bottom
        )
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8), value: isDragging)
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture().onChanged { value in
                self.viewState = value.translation
                self.isDragging = true
            }
            .onEnded { value in
                self.viewState = .zero
                self.isDragging = false
            }
        )
    }
}

struct BackgroundView: View {
    @Binding var show: Bool
    @Binding var viewState: CGSize
    
    var body: some View {
        ZStack {
            BlobView(show: $show, offsetValue: CGSize(width: -150, height: -200), rotationStart: 90, rotationEnd: 360 + 90)
            
            BlobView(show: $show, offsetValue: CGSize(width: -200, height: -250), rotationStart: 0, rotationEnd: 360)
        }
    }
}


struct TitleCoverView: View {
    @Binding var viewState: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            Text("Learn Hebrew.\nFrom scratch.")
                .font(.system(size: geometry.size.width/10, weight: .bold))
                .foregroundColor(.white)
        }
        .frame(maxWidth: 375, maxHeight: 100)
        .padding(.horizontal, 16)
        .offset(x: viewState.width/15, y: viewState.height/15)
    }
}

struct DescriptionText: View {
    @Binding var viewState: CGSize
    
    var body: some View {
        Text("20 hours of interactive courses and games for new beginners to adopt the Hebrew language. \n בואו נתחיל")
            .font(.subheadline)
            .frame(width: 250)
            .offset(x: viewState.width/20, y: viewState.height/20)
    }
}

#Preview{CoverView()}
