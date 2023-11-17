//
//  HomeView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/24/23.
//
//Purpose: The HomeView is a subview within the Home view, focusing on displaying specific content such as courses, sections, watch rings, and more.

import SwiftUI
import RealityKit
import ARKit
import PencilKit

enum ActiveSheet {
    case arGameView ,drawingView, none
}



//struct HomeViewController: View {
//
//    //pencilkit
//       @State private var drawing = PKDrawing()
//       @State private var tool: PKTool = PKInkingTool(.pen, color: .black, width: 15)
//       @State private var  showDrawingView = false
//       //arkit
//       @State private var showARView = false
//       @State var arView = ARView(frame: .zero)
//       // active sheet
//       @State private var activeSheet: ActiveSheet = .none
//   
//   
//   
//       @State var showUpdate = false
//       @Binding var showProfile : Bool
//       @Binding var showContent: Bool
//       @State var active = false // This would control the blurring effect
//       @State var activeIndex = -1
//        @State var isScrollable = false
//       @State var activeView = CGSize.zero
//       @Binding var viewState : CGSize
//   
//       @ObservedObject var store = CourseStore()
//       @EnvironmentObject var databaseService : DatabaseManager
//       @EnvironmentObject var notificationManager : NotificationManager
//   
//   
//       @Environment(\.horizontalSizeClass) var horizontalSizeClass
//      
//   
//    
// 
//    
//    var body: some View {
//        GeometryReader { geometry in
//            ScrollView(showsIndicators: false) {
//                VStack {
//                    Header(showProfile: $showProfile, showUpdate: $showUpdate )
//                        .blur(radius: active ? 20 : 0)
//                    
//                    WatchringsView()
//                        .onTapGesture {
//                                                      $showContent.wrappedValue = true
//                                                  }
//                        .frame(height: geometry.size.width / 4) // Example of using GeometryReader
//                        .blur(radius: active ? 20 : 0)
//                    
//                    SectionsComponent(activeSheet: $activeSheet,showDrawingView: $showDrawingView)
//                        .frame(height: geometry.size.width / 3) // Adjust height based on GeometryReader
//                        .blur(radius: active ? 20 : 0)
//                  //  courseShop title
//                              HStack {
//                                  Text("Courses Shop")
//                                      .font(.title)
//                                      .fontWeight(.bold)
//              
//                                  Image(systemName: K.Images.bag)
//                                      .fontWeight(.bold).font(.title)
//              
//                                  Spacer()
//                              }///hstak
//                              .padding(.leading, 30)
//                              .offset(y: -60)
//                              .blur(radius: active ? 20 : 0)
//                              
//                    CourseList(active: $active, activeIndex: $activeIndex, activeView: $activeView, isScrollable: $isScrollable)
//                        .blur(radius: active ? 20 : 0)
//                    
//                    Spacer() // This will push all content to the top
//                }
//                .disabled(self.active && !self.isScrollable ? true : false) // If active, disable interaction with the scroll view
//            }
//            .padding(.top) // Add padding if necessary
//          //  .animation(.easeInOut) // Add animation if needed
//            .frame(width: geometry.size.width) // Use GeometryReader for dynamic width
//        }
//    }
//}


////Purpose: The Home view appears to be the main container view for your application. It manages the overall layout,
struct HomeView: View {
    //pencilkit
    @State private var drawing = PKDrawing()
    @State private var tool: PKTool = PKInkingTool(.pen, color: .black, width: 15)
    @State private var  showDrawingView = false
    //arkit
    @State private var showARView = false
    @State var arView = ARView(frame: .zero)
    // active sheet
    @State private var activeSheet: ActiveSheet = .none
    
  

    @State var showUpdate = false
    @Binding var showProfile : Bool
    @Binding var showContent: Bool
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @Binding var viewState : CGSize
    
    @ObservedObject var store = CourseStore()
    @EnvironmentObject var databaseService : DatabaseManager
    @EnvironmentObject var notificationManager : NotificationManager
    
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var isScrollable = false
    
    private func handleTap(for item: SectionModel) {
        switch item.text {
        case "AR Game":
            print("AR section tapped")
            activeSheet = .arGameView
        case "Coloring Book":
            print("Color section tapped")
            activeSheet = .drawingView
            showDrawingView = true
        default:
            print("Unhandled section tapped")
        }
    }
    var body: some View {
        
        GeometryReader { bounds in
            
            ScrollView(showsIndicators: false) {
                
                VStack {
                    ///"learning" text & tapbar
                Header(showProfile: $showProfile, showUpdate: $showUpdate)
//                        HStack {
//                            Text("Learning")
//                                .font(.title)
//                                .fontWeight(.bold)
//                            Image(systemName: K.Images.eyeglasses)
//                                .fontWeight(.bold).font(.title)
//                            
//                            Spacer()
//                            
//                            AvatarView(showProfile: $showProfile )
//                            
//                            Button(action: { self.showUpdate.toggle() }) {
//                                FeatureButton(name: "bell")
//                                    .foregroundColor(.black)
//                            }
//                            ///model presentation
//                            .sheet(isPresented: $showUpdate) {
//                                UpdateList(notificationManager: notificationManager)
//                            }
//                        }
                           
                        .offset(y: 30)
                        .padding(.horizontal)
                        .padding(.leading, 14)
                        .padding(.top, 30)
                        .blur(radius: self.active ? 20 : 0)
                    ///watchringsview component
                    ScrollView(.horizontal ,showsIndicators : false) {
                        WatchringsView()
                            //.watchRingsViewModifiers(showContent: $showContent, active: active)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .padding(.top, 40)
                            .onTapGesture {
                                self.showContent = true
                            }
                        
                    }
                    .blur(radius: active ? 20 : 0)
                    
                    
                    ///sectionscrollview
                    ScrollView (.horizontal, showsIndicators: false){
                        //all sectionViews will be spread horizantally
                        HStack(spacing: 30) {
                            
                            ForEach(sectionData) { item in
                                
                                GeometryReader { geometry in
                                    SectionView(section: item)
                                    //3d scroll animation
                                        .blur(radius: active ? 20 : 0 )
                                        .rotation3DEffect(Angle(degrees:
                                                                    Double(geometry.frame(in: .global).minX - 40) / -getAngleMultiplier(bounds: bounds)
                                                               ), axis: (x: 0, y: 10.0, z: 0))
                                        .onTapGesture {
                                           self.handleTap(for: item)
                                            
                                        }//on tap
                              
                                }
                                .frame(width: 275,height: 275)
//                                ///managing the activeSheet
//                                .sheetPresenter(activeSheet: $activeSheet,
//                                                arView: $arView,
//                                                drawing: $drawing,
//                                                showProfile: $showProfile,
//                                                showContent: $showContent,
//                                                viewState: $viewState, showDrawingView: $showDrawingView,
//                                                tool: $tool)
                               // .padding(5)
                            
                                ///.seet used to be
                                }
                                
                            }
                        .padding(30)
                        .padding(.bottom,30)
                        }
                    ///managing the activeSheet
                    .sheetPresenter(activeSheet: $activeSheet,
                                    arView: $arView,
                                    drawing: $drawing,
                                    showProfile: $showProfile,
                                    showContent: $showContent,
                                    viewState: $viewState, showDrawingView: $showDrawingView,
                                    tool: $tool)
                      
                    
                    .offset(y: -30)
                    .blur(radius: active ? 20 : 0)
          
                
                //courseShop title
                HStack {
                    Text("Courses Shop")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Image(systemName: K.Images.bag)
                        .fontWeight(.bold).font(.title)
                    
                    Spacer()
                }///hstak
                .padding(.leading, 30)
                .offset(y: -60)
                .blur(radius: active ? 20 : 0)
                
                
//                //   course List CourseList
//                VStack (spacing: 30){
//                    ForEach(self.store.courses.indices, id: \.self) { index in
//                        GeometryReader { geometry in
//                            CourseViewController(
//                                show: self.$store.courses[index].show,
//                                course: self.store.courses[index],
//                                active: self.$active,
//                                index: index,
//                                activeIndex: self.$activeIndex,
//                                activeView: self.$activeView,
//                                bounds: bounds,
//                                isScrollable: self.$isScrollable
//                            )
//                                .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
//                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
//                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
//                                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
//                        }
//                        .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
//                        .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
//                        .zIndex(self.store.courses[index].show ? 1 : 0)
//                    }
//                    
//                }///vstack course view
//                .padding(.bottom, 300)
//                .offset(y: -60)
                
                Spacer()
               
                
            } ///vstack 1st
                ///main modifiers
                .frame(width: bounds.size.width)
                .shadow(color: Color(.black).opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(self.viewState.height / -10)-10 : 0), axis: (x: 10, y: 0, z: 0))
                
                .scaleEffect(Double(showProfile ? 0.9 : 1))
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0),value:showProfile)
            }///scrollview
            .disabled(self.active && !self.isScrollable ? true : false)
        } ///main greader
    }//main
}//struct



 




///watchRingsViewModifiers
//extension View {
//    func watchRingsViewModifiers(showContent: Binding<Bool>, active: Bool) -> some View {
//        self
//            .padding(.horizontal, 30)
//            .padding(.bottom, 30)
//            .padding(.top, 40)
//            .onTapGesture {
//                showContent.wrappedValue = true
//            }
//          //  .blur(radius: active ? 20 : 0)
//    }
//}





/////restart homeviewcontroler
//import SwiftUI
//
//struct HomeViewController: View {
//    @Binding var showProfile: Bool
//    @State var showUpdate = false
//    @Binding var showContent: Bool
//    @Binding var viewState: CGSize
//    @ObservedObject var store = CourseStore()
//    @State var active = false
//    @State var activeIndex = -1
//    @State var activeView = CGSize.zero
//    @Environment(\.horizontalSizeClass) var horizontalSizeClass
//    @State var isScrollable = false
//    
//    var body: some View {
//        GeometryReader { bounds in
//            ScrollView {
//                VStack {
//                    HStack(spacing: 12) {
//                        Text("Watching")
//                            .font(.system(size: 28, weight: .bold))
//                            .modifier(CustomFontModifier(size: 28))
//                        
//                        Spacer()
//                        
//                        AvatarView(showProfile: self.$showProfile)
//                        
//                        Button(action: { self.showUpdate.toggle() }) {
//                            Image(systemName: "bell")
//    //                            .renderingMode(.original)
//                                .foregroundColor(.primary)
//                                .font(.system(size: 16, weight: .medium))
//                                .frame(width: 36, height: 36)
//                                .background(Color("background3"))
//                                .clipShape(Circle())
//                                .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
//                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
//                        }
//                        .sheet(isPresented: self.$showUpdate) {
//                            UpdateList()
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.leading, 14)
//                    .padding(.top, 30)
//                    .blur(radius: self.active ? 20 : 0)
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        WatchringsView()
//                            .padding(.horizontal, 30)
//                            .padding(.bottom, 30)
//                            .onTapGesture {
//                                self.showContent = true
//                        }
//                    }
//                    .blur(radius: self.active ? 20 : 0)
//                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 20) {
//                            ForEach(sectionData) { item in
//                                GeometryReader { geometry in
//                                    SectionView(section: item)
//                                        .rotation3DEffect(Angle(degrees:
//                                            Double(geometry.frame(in: .global).minX - 30) / -getAngleMultiplier(bounds: bounds)
//                                        ), axis: (x: 0, y: 10, z: 0))
//                                }
//                                .frame(width: 275, height: 275)
//                            }
//                        }
//                        .padding(30)
//                        .padding(.bottom, 30)
//                    }
//                    .offset(y: -30)
//                    .blur(radius: self.active ? 20 : 0)
//                    
//                    HStack {
//                        Text("Courses")
//                            .font(.title).bold()
//                        Spacer()
//                    }
//                    .padding(.leading, 30)
//                    .offset(y: -60)
//                    .blur(radius: self.active ? 20 : 0)
//                    
//                    VStack(spacing: 30) {
//                        ForEach(self.store.courses.indices, id: \.self) { index in
//                            GeometryReader { geometry in
//                                CourseViewController(show: self.$store.courses[index].show, course: self.store.courses[index], index: index, bounds:  bounds, active: $active, activeIndex: $activeIndex, activeView: $activeView, isScrollable: $isScrollable)(
//                                    show: self.$store.courses[index].show,
//                                    course: self.store.courses[index],
//                                    active: self.$active,
//                                    index: index,
//                                    activeIndex: self.$activeIndex,
//                                    activeView: self.$activeView,
//                                    bounds: bounds,
//                                    isScrollable: self.$isScrollable
//                                )
//                                    .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
//                                    .opacity(self.activeIndex != index && self.active ? 0 : 1)
//                                    .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
//                                    .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
//                            }
//                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
//                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
//                            .zIndex(self.store.courses[index].show ? 1 : 0)
//                        }
//                    }
//                    .padding(.bottom, 300)
//                    .offset(y: -60)
//                    
//                    Spacer()
//                }
//                .frame(width: bounds.size.width)
//                .offset(y: self.showProfile ? -450 : 0)
//                .rotation3DEffect(Angle(degrees: self.showProfile ? Double(self.viewState.height / 10) - 10 : 0), axis: (x: 10.0, y: 0, z: 0))
//                .scaleEffect(self.showProfile ? 0.9 : 1)
//                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
//            }
//            .disabled(self.active && !self.isScrollable ? true : false)
//        }
//    }
//}
//
//
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeViewController(showProfile: .constant(false), showContent: .constant(false), viewState: .constant(.zero))
//        .environmentObject(UserStore())
//    }
//}
//
