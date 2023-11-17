//
//  CourseView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/7/23.
//

import SwiftUI
import SDWebImageSwiftUI
//how the cours view looks from the cours list!
struct CourseViewController: View {
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var bounds: GeometryProxy
    @Binding var isScrollable: Bool
    @StateObject var paymentManager = PaymentManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.top,25)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    //the circle will show the courses logo when courseDetail is not shown (in main view).
                    ZStack {
                        Image(uiImage: course.logo)
                            .resizable()
                            .frame(width: 40,height: 40)
                            .clipShape(Circle())
                            .opacity(show ? 0 : 1)
                       // once a course is tapped the circle will present the x button
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .offset(x: 2, y: -2)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, CGFloat(show ? 30 : 0))
            
            .frame(height: show ? (bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom) : 280)
            
            .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            
         
            //.disabled(active && isScrollable ? true : false)
            // When the course card is tapped, both the show and active boolean states are toggled.
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                    print(self.activeIndex)
                } else {
                    self.activeIndex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() ) {
                    self.isScrollable = true
                }
            }
            //when  course is tapped isScrollable = true and show the courseDetail view
            if isScrollable {
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                    .environmentObject(paymentManager)
                    .background(K.Colors.bkgColor1)
                    .clipShape(RoundedRectangle(cornerRadius: show ? getCardCornerRadius(bounds: bounds) : 30, style: .continuous))
                   // .animation(nil, value:isScrollable)
                    .transition(.identity)
                    
                    
                    
            }
        }
        .frame(height: show ? bounds.size.height + bounds.safeAreaInsets.top + bounds.safeAreaInsets.bottom : 280)
        .scaleEffect(1 - activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        .hueRotation(Angle(degrees: Double(activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0),value: show)

//            .gesture(
//                show ?
//                DragGesture().onChanged { value in
//                    guard value.translation.height < 300 else { return }
//                    guard value.translation.height > 50 else { return }
//        
//                    self.activeView = value.translation
//                }
//                    .onEnded { value in
//                        if self.activeView.height > 50 {
//                            self.show = false
//                            self.active = false
//                            self.activeIndex = -1
//                            self.isScrollable = false
//                        }
//                        self.activeView = .zero
//                    }
//                : nil
//            )
           
        
        
        .edgesIgnoringSafeArea(.all)
    }
}

