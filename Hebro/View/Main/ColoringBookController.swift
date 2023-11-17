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
    @Binding var showDrawingView :Bool
   

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                /// Drawing and Tool Picker
                VStack(alignment: .center)
                {
                    
                    ///presenting
                    ToolPicker(tool: $tool,drawing: $drawing)
                        .id(UUID())
                        .closeButton(show: $showDrawingView)
                   
                }
                .edgesIgnoringSafeArea(.bottom)
            
            }
            .edgesIgnoringSafeArea(.all) /// Ensure the view takes the entire screen
        
        }
        .onChange(of: showDrawingView) {
                   // This will be called whenever showDrawingView changes.
                   if !showDrawingView {
                       activeSheet = .none
                   }
               }
    }
    
}
