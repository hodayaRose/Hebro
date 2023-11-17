//
//  CourseDetail.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//

///this view is displayed when a course from CourseList  is being tapped

import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show : Bool
    @Binding var active : Bool
    @Binding var activeIndex : Int
    @Binding var isScrollable: Bool
    @ObservedObject var store = CourseStore()
    @ObservedObject var paymentManager: PaymentManager
    @State private var isDraggable = false
    
    
    var bounds: GeometryProxy
    var body: some View {
        
        
        
        // Check if there's an active course and if scrolling is enabled
        if  isScrollable && activeIndex >= 0 && activeIndex < store.courses.count {
            let courseDetail = store.courses[activeIndex] // Get the active course
            ScrollView(showsIndicators:false ){
                VStack{
                    /// the title and subtitle top section of courseDetail
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(courseDetail.title)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                Text(courseDetail.subtitle)
                                    .foregroundColor(Color.white.opacity(0.7))
                            }
                            .padding(.top, 30)
                            Spacer()
                            ///the x button to dissmiss the view and go back to courseList
                            ZStack {//TODO: CHANGE TO BUTTON COMPONENT
                                
                                VStack{
                                    
                                    //  Spacer()
                                    
                                    Image(systemName: "xmark")
                                        .frame(width: 36, height: 36)
                                        .foregroundColor(.white)
                                }
                                .background(Color.black)
                                .clipShape(Circle())
                                .onTapGesture {
                                    //hide the courseDetail view when  clicking on course button
                                    self.show = false
                                    self.active = false
                                    self.activeIndex = -1
                                    self.isScrollable = false
                                    
                                    
                                    
                                    // Spacer()
                                }
                                // .padding()
                                
                                
                                
                            }
                        }
                        Spacer()
                        ///background course image
                        WebImage(url: course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 140, alignment: .top)
                    }
                    .padding(show ? 30 : 20)
                    .padding(.top, CGFloat(show ? 30 : 0))
                    
                    .frame(maxWidth: CGFloat(show ? .infinity : bounds.size.width - 60))
                    .frame(height: CGFloat(show ? 350 : 280))
                    .background(Color(course.color))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                    
                    
                    ///present the headline and content of course
                    CourseContent(activeIndex: $activeIndex, cd: self, store: store)
                        .padding(30)
                    
                    Spacer()
                    ///purchase the course with applePay
                    PaymentButton(action: paymentManager.pay)
                        .padding(30)
                        .offset(y:-30)
                }
                
            }
            
            .edgesIgnoringSafeArea(.all)
            
            
            
            
        }
    }
    
}





