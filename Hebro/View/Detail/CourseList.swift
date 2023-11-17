//
//  CourseList.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 7/25/23.
//


import SwiftUI
import SDWebImageSwiftUI
import Foundation


// a view that shows the course list component it shouldve replace the vstack in the middle of homeView
//but since i needed the direct bounds from geometryreader and not the transferred bounds ive implemented the code drectly in homeview
struct CourseList: View {
    
    @ObservedObject var store = CourseStore()
    @EnvironmentObject var databaseService : DatabaseManager
    @Binding var active :Bool
    @Binding var activeIndex :Int
    @Binding var activeView : CGSize
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Binding var isScrollable :Bool
    var bounds : GeometryProxy
    var body: some View{

                    
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
                    .padding(.bottom, 100)
                    .padding(.top,25)
                    .offset(y: -60)
                    
                    Spacer()
                    

                }
                
           
            }
      
