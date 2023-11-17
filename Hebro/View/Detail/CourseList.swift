//
//  CourseList.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//


import SwiftUI
import SDWebImageSwiftUI


// a view that shows the course list in a scrollable view
struct CourseList: View {
    
   
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
   
    // Function to create the course views
    func courseViews(bounds: GeometryProxy) -> some View {
        ForEach(store.courses.indices, id: \.self) { index in
            GeometryReader { geometry in
                CourseViewController(
                    show: self.$store.courses[index].show,
                    course: self.store.courses[index],
                    active: self.$active,
                    index: index,
                    activeIndex: self.$activeIndex,
                    activeView: self.$activeView,
                    bounds: bounds,
                    isScrollable: self.$isScrollable
                )
                .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
            }
            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
            .zIndex(self.store.courses[index].show ? 1 : 0)
        }
    }
    var body: some View {
        //keeps screen size dynamic
        GeometryReader { bounds in
            ZStack {
                //background color
                BackgroundColor(activeView: $activeView)
                
                
                ZStack{
                    VStack(spacing: 30) {
                        Text("Courses Shop ")
                            .font(.largeTitle).bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 30)
                            .padding(.top, 30)
                            .blur(radius: active ? 20 : 0)
                        //Foreach course creat a courseView
                        courseViews(bounds: bounds)
                    }
                    .frame(width: bounds.size.width)
                    .animation(.spring(response: 0.7, dampingFraction: 0.9, blendDuration: 0),value: active
                    )
                }
                .statusBar(hidden: active ? true : false)
                .animation(.linear, value:active )
                
//                //trial1
//                 .disabled(self.active && self.isScrollable ? false : true)
            }
        }
        
        
        
    }
    
}


struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
            .environmentObject(DatabaseManager())
    }
}







struct BackgroundColor: View {
    @Binding var activeView : CGSize
    var body: some View {
        Color.black.opacity(Double(self.activeView.height/500))
            .animation(.linear)
            .edgesIgnoringSafeArea(.all)
    }
}
