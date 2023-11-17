//
//  CourseContent.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI
///displaed in courseDetail
struct CourseContent: View {
    
    @Binding var activeIndex : Int
    @State var cd : CourseDetail
    @ObservedObject var store :CourseStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30.0) {
            
            
            Text("About this course")
                .font(.title).bold()
            //load headline from contentful API
            if activeIndex >= 0 && activeIndex < store.courses.count {
                Text(cd.store.courses[activeIndex].headline)
                    .font(.subheadline).bold()
                    .foregroundColor(Color(cd.course.color))
                // Load course content for contentful API
                Text(cd.store.courses[activeIndex].content)
            }
        }
        
    }
}

