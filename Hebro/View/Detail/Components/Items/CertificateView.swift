//
//  MainView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/7/23.
//


import SwiftUI

// MARK: - CertificateView

struct CertificateView: View {
    
    @State private var show = false
    //store x,y position of my drag to use with Animations later on
    @State private var viewState = CGSize.zero
    //state to show the full view of the UI
    @State private var showCard = false
    @State private var bottomState = CGSize.zero
    @State  private var showFull = false
    @EnvironmentObject var databaseService : DatabaseManager
    var body: some View {
        ZStack{
            ///Background view
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(.default.delay(0.1), value: showCard)
            
            
            
            
            withAnimation(.easeInOut(duration: 0.5)) {
                BackCardView()
                    .frame(maxWidth:showCard ? 300 : 340)
                    .frame(height: 220)
                    .background(show ? Color("card4") : Color("card3"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0,y: show ? -400 : -40
                    )
                    .offset(x: viewState.width, y: viewState.height)
                    .offset(y: showCard ? -180 : 0)
                    .scaleEffect(showCard ? 1 : 0.9)
                    .rotationEffect(Angle(degrees: show ? 0 : 10))
                    .rotationEffect(.degrees(showCard ? -10 : 0))
                    .rotation3DEffect(.degrees(showCard ? 0 : 10), axis: (x: 10, y: 0, z: 0))
                    .blendMode(.hardLight)
            }
            withAnimation(.easeInOut(duration: 0.3)) {
                BackCardView()
                    .frame(maxWidth: 340)
                    .frame(height: 220)
                    .background(show ? Color("card3") : Color("card4"))
                    .cornerRadius(20)
                    .shadow(radius: 20)
                    .offset(x: 0, y: show ? -200 : -20)
                    .offset(x: viewState.width, y: viewState.height)
                    .offset(y: showCard ? -140 : 0)
                    .scaleEffect(showCard ? 1 : 0.95)
                    .rotationEffect(Angle(degrees: show ? 0 : 5))
                    .rotationEffect(.degrees(showCard ? -5 : 0))
                    .rotation3DEffect(.degrees(showCard ? 0 : 5), axis: (x: 10, y: 0, z: 0))
                    .blendMode(.hardLight)
            }
            
            
            
            //front card view
            CardView()
                .frame(maxWidth: showCard ? 375 : 340)
                .frame(height: 220)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 20 : 30,style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
            
                .onTapGesture {
                    
                    withAnimation(.spring(response: 0.3,dampingFraction: 0.6, blendDuration: 0)) {
                        show.toggle()
                        showCard.toggle()
                        
                    }
                    
                    
                    
                }
            ///drage gesture activates drage effect
                .gesture(
                    ///every drag value is being stored in viewsState
                    
                    DragGesture().onChanged { value in
                        withAnimation(.spring(response: 0.3,dampingFraction: 0.6, blendDuration: 0)){
                            self.viewState = value.translation
                            self.show = true
                        }
                    }
                    
                    
                        .onEnded({ value in
                            /// when drag released the position is set to 0 the view return to its original position.
                            withAnimation(.spring(response: 0.3,dampingFraction: 0.6, blendDuration: 0)){
                                self.viewState = .zero
                                self.show = false
                            }
                        })
                    
                )
            /// BottomCardView will be displayed when CardView is pressed and its size ajdusts dinamically
            GeometryReader { bounds in
                BottomCardView(show: $showCard)
                    .offset(x: 0, y:   withAnimation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8)) {showCard ? bounds.size.height / 2 : bounds.size.height
                        + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom
                    }
                    )
                    .offset(y: bottomState.height)
                    .blur(radius: showCard ? 0 : 20)
                    .gesture(
                        DragGesture().onChanged{
                            value in
                            
                            
                            self.bottomState = value.translation
                            //offset will only apply when showFull = true
                            if self.showFull{
                                self.bottomState.height += -300
                                
                            }
                            if self.bottomState.height < -300{
                                self.bottomState.height = -300
                            }
                            
                        }
                            .onEnded{_ in
                                
                                if self.bottomState.height > 50{
                                    self.showCard = false
                                }
                                if( self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull ){
                                    self.bottomState.height = -300
                                    self.showFull = true
                                }
                                else{
                                    self.bottomState = .zero
                                    self.showFull = false
                                }
                                
                            }
                    )
            }
            
            
            
            
        }
    }
}


//VIEW COMPONENTS EXTENTION
// MARK: - CardView
struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    // Text
                    Text("Hebrew for starters")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color(.white))
                        .font(.system(size: 20))
                }
                Spacer()
                Image(K.Images.logoCircle).resizable().frame(width: 40,height: 40)
                
            }
            .padding(.horizontal,20)
            .padding(.top,20)
            Spacer()
            SwiftUI.Image(K.Images.Card1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300,height: 110,alignment: .top)
            
        }
        
    }
}
// MARK: - BackCardView
struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}
//the background view
// MARK: - TitleView
struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image(K.Images.Background1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 375)
            Spacer()
        }
    }
}
//shows when front card is pressed.
// MARK: - BottomCardView
struct BottomCardView: View {
    @Binding var show: Bool
    var body: some View {
        VStack (spacing:20){
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1
                )
            Text(K.BottomCardViewText)
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack (spacing: 20){
                //showing the courses progress when $show state changes
                withAnimation{
                    RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 88, height: 88, percent: ((2/8)*100), show:$show)
                    
                        .animation(.easeInOut(duration: 0.4),value: show)
                }
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Create Sentences")
                        .fontWeight(.bold)
                    Text("2 of 8 sections completed \n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(K.Colors.bkgColor3)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            
            
            
            Spacer()
        }
        .padding(.top,8)
        .padding(.horizontal,20)
        .frame(maxWidth: .infinity)
        
        .background(.ultraThinMaterial)
        
        .cornerRadius(30)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity)
        
    }
}




// MARK: - Preview
#Preview{
    CertificateView()
}



