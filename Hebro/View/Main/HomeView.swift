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
                        .padding(.bottom,40)
                        .offset(y: 50)
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
                    CourseShopTitleView()
                        .padding(.bottom,15)
                        .blur(radius: active ? 20 : 0)
                    
                    
                    //                //   course List CourseList
                    
                    
                    VStack (spacing: 30){
                        
                        
                        
                        ForEach(self.store.courses.indices, id: \.self) { index in
                            GeometryReader { geometry in
                                CourseViewController(
                                    show: self.$store.courses[index].show,
                                    course: self.store.courses[index],
                                    index: index ,
                                    bounds: bounds,
                                    active: self.$active ,
                                    activeIndex: self.$activeIndex ,
                                    activeView:self.$activeView ,
                                    isScrollable: self.$isScrollable
                                )
                                .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? bounds.size.width : 0)
                            }
                            .frame(height: self.horizontalSizeClass == .regular ? 80 : 280)
                            .frame(maxWidth: self.store.courses[index].show ? 712 : getCardWidth(bounds: bounds))
                            .zIndex(self.store.courses[index].show ? 1 : 0)
                            
                        }
                        
                    }
                    .padding(.bottom, 40)
                    .padding(.top,10)
                    .offset(y: -60)
                    
                    Spacer()
  
                        .padding(.bottom, 60)
                     
                    
                    
                }
                ///main modifiers
                .frame(width: bounds.size.width)
                .shadow(color: Color(.black).opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(self.viewState.height / -10)-10 : 0), axis: (x: 10, y: 0, z: 0))
                
                .scaleEffect(Double(showProfile ? 0.9 : 1))
                .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0),value:showProfile)
            }///scrollview
            .disabled(self.active && !self.isScrollable ? true : false)
        
        }
    }
}



 










