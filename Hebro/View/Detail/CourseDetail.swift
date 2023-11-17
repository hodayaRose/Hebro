//
//  CourseDetail.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//
//this view it displayed when a course is being tapped
//import SwiftUI
//import SDWebImageSwiftUI
//
//struct CourseDetail: View {
//    var course: Course
//    @Binding var show : Bool
//    @Binding var active : Bool
//    @Binding var activeIndex : Int
//    @Binding var isScrollable: Bool
//    @ObservedObject var store = CourseStore()
//    @EnvironmentObject var paymentManager: PaymentManager
//    
//    
//    var bounds: GeometryProxy
//    var body: some View {
//        // Wrapping the content inside GeometryReader
//        GeometryReader { geometry in
//            // Check if there's an active course and if scrolling is enabled
//            if active && isScrollable && activeIndex >= 0 && activeIndex < store.courses.count {
//                let courseDetail = store.courses[activeIndex] // Get the active course
//                ZStack{
//                    //the title and subtitle top section of courseDetail
//                    VStack {
//                        HStack(alignment: .top) {
//                            VStack(alignment: .leading, spacing: 8.0) {
//                                Text(courseDetail.title)
//                                    .font(.system(size: 24, weight: .bold))
//                                    .foregroundColor(.white)
//                                Text(courseDetail.subtitle)
//                                    .foregroundColor(Color.white.opacity(0.7))
//                            }
//                            Spacer()
//                            //the x button to dissmiss the view and go back to courseList
//                            ZStack {
//                                
//                                VStack{
//                                    HStack {
//                                        Spacer()
//                                        
//                                        Image(systemName: "xmark")
//                                            .frame(width: 36, height: 36)
//                                            .foregroundColor(.white)
//                                            .background(Color.black)
//                                            .clipShape(Circle())
//                                    }
//                                    
//                                    Spacer()
//                                }
//                                .padding()
//                                .onTapGesture {
//                                    //hide the courseDetail view when  clicking on course button
//                                    self.show = false
//                                    self.active = false
//                                    self.activeIndex = -1
//                                    self.isScrollable = false
//                                }
//                                
//                                
//                            }
//                        }
//                        Spacer()
//                        
//                        WebImage(url: course.image)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 120, alignment: .top)
//                    }
//                    .padding(show ? 30 : 20)
//                    .padding(.top, CGFloat(show ? 30 : 0))
//                    
//                    .frame(maxWidth: CGFloat(show ? .infinity : bounds.size.width - 60), maxHeight: CGFloat(show ? 460 : 280))
//                    .background(Color(course.color))
//                    .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
//                    .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
//                    
//                    
//                    //present the headline and content of course
//                    
//                    
//                    
//                    CourseContent(activeIndex: $activeIndex, cd: self)
//                        .padding(30)
//                    
//                    Spacer()
//                    //purchase the course with applePay
//                    PaymentButton(action: paymentManager.pay)
//                        .padding(25)
//                        .offset(y:-30)
//                }
//               // .disabled(active && isScrollable ? true : false)
//                
//                .frame(width: geometry.size.width, height: geometry.size.height) // Use the geometry to set the frame
//                .edgesIgnoringSafeArea(.all)
//                
//            }
//            
//        }
//    }
//}
//
//
//
//
//
//struct CourseContent: View {
//    
//    @Binding var activeIndex : Int
//    @State var cd : CourseDetail
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 30.0) {
//            
//            
//            Text("About this course")
//                .font(.title).bold()
//            //load headline from contentful API
//            Text(cd.store.courses[activeIndex].headline)
//                .font(.subheadline).bold()
//                .foregroundColor(Color(cd.course.color))
//            // Load course content for contentful API
//            Text(cd.store.courses[activeIndex].content)
//        }
//        
//    }
//}
import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show : Bool
    @Binding var active : Bool
    @Binding var activeIndex : Int
    @Binding var isScrollable: Bool
    @ObservedObject var store = CourseStore()
    @EnvironmentObject var paymentManager: PaymentManager
    @State private var isDraggable = false
    
    
    var bounds: GeometryProxy
    var body: some View {
        // Wrapping the content inside GeometryReader
        GeometryReader { geometry in
            // Check if there's an active course and if scrolling is enabled
            if active && isScrollable && activeIndex >= 0 && activeIndex < store.courses.count {
                let courseDetail = store.courses[activeIndex] // Get the active course
                VStack{
                    //the title and subtitle top section of courseDetail
                    VStack {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 8.0) {
                                Text(courseDetail.title)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                                Text(courseDetail.subtitle)
                                    .foregroundColor(Color.white.opacity(0.7))
                            }
                            Spacer()
                            //the x button to dissmiss the view and go back to courseList
                            ZStack {
                                
                                VStack{
                                    HStack {
                                        Spacer()
                                        
                                        Image(systemName: "xmark")
                                            .frame(width: 36, height: 36)
                                            .foregroundColor(.white)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .onTapGesture {
                                    //hide the courseDetail view when  clicking on course button
                                    self.show = false
                                    self.active = false
                                    self.activeIndex = -1
                                    self.isScrollable = false
                                }
                                
                                
                            }
                        }
                        Spacer()
                        
                        WebImage(url: course.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 120, alignment: .top)
                    }
                    .padding(show ? 30 : 20)
                    .padding(.top, CGFloat(show ? 30 : 0))
                    
                    .frame(maxWidth: CGFloat(show ? .infinity : bounds.size.width - 60), maxHeight: CGFloat(show ? 460 : 280))
                    .background(Color(course.color))
                    .clipShape(RoundedRectangle(cornerRadius: getCardCornerRadius(bounds: bounds), style: .continuous))
                    .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                    
                    
                    //present the headline and content of course
                    
                    
                    
                    CourseContent(activeIndex: $activeIndex, cd: self)
                        .padding(30)
                    
                    Spacer()
                    //purchase the course with applePay
                    PaymentButton(action: paymentManager.pay)
                        .padding(25)
                        .offset(y:-30)
                }
            
           
                .frame(width: geometry.size.width, height: geometry.size.height) // Use the geometry to set the frame
                .edgesIgnoringSafeArea(.all)
                
            }
            
        }
    }
}





struct CourseContent: View {
    
    @Binding var activeIndex : Int
    @State var cd : CourseDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30.0) {
            
            
            Text("About this course")
                .font(.title).bold()
            //load headline from contentful API
            Text(cd.store.courses[activeIndex].headline)
                .font(.subheadline).bold()
                .foregroundColor(Color(cd.course.color))
            // Load course content for contentful API
            Text(cd.store.courses[activeIndex].content)
        }
        
    }
}
