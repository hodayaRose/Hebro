//
//  ColoringView.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 10/4/23.
//

import SwiftUI
import PencilKit

struct ColoringBookController: View {
    
    @Binding var drawing: PKDrawing
    @Binding var activeSheet : ActiveSheet
    @Binding var tool: PKTool
    @State var isLandscape = UIDevice.current.orientation.isLandscape
   
   

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Drawing and Tool Picker
                VStack(alignment: .center)
                {
                    
                    //presenting
                    ToolPicker(tool: $tool,drawing: $drawing)
                        .id(UUID())
                    //
                }
                .edgesIgnoringSafeArea(.bottom)
                
                // "x" Mark Button
                
                VStack {
                    HStack {
                        Button(action: {
                          //  showDrawingView = false
                            activeSheet = .none
                        }) {
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(.black)
                                .clipShape(Circle())
                        }
                        .padding(.top,20)
                        .padding(.horizontal,30)
                        .offset(y: self.isLandscape ? 25 : 25)
                        Spacer()
                    }
                    Spacer()
                }
                
            }
            .edgesIgnoringSafeArea(.all) // Ensure the view takes the entire screen
            //manages updates toisLandscape the view orientation
            .onAppear {
                // Add an observer to monitor orientation changes
                NotificationCenter.default.addObserver(
                    forName: UIDevice.orientationDidChangeNotification,
                    object: nil,
                    queue: .main
                ) { _ in
                    // Update the orientation state variable
                    self.isLandscape = UIDevice.current.orientation.isLandscape
                }
            }
            .onDisappear {
                // Remove the observer when the view disappears
                NotificationCenter.default.removeObserver(UIDevice.orientationDidChangeNotification)
            }
        }
    }
}
