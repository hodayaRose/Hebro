//
//  SheetPresenter.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 11/8/23.
//

import SwiftUI
import ARKit
import RealityKit
import PencilKit
enum ActiveSheet {
    case arGameView ,drawingView, none
}
struct SheetPresenter: ViewModifier {
    @Binding var activeSheet: ActiveSheet
    @Binding var arView: ARView
    @Binding var drawing: PKDrawing
    @Binding var tool: PKTool
    @Binding var showDrawingView:Bool

    @Binding var showProfile: Bool
    @Binding var showContent: Bool
    @Binding var viewState: CGSize

    func body(content: Content) -> some View {
        content
        //showing a selected sheet managedby the active state
        .sheet(isPresented: .constant(activeSheet != .none)) {
            
                   switch activeSheet {
                   case .arGameView:
                       ARViewController(activeSheet: $activeSheet, arView : $arView)
                   case .drawingView:
                       ColoringBookController(drawing: $drawing, activeSheet: $activeSheet, tool: $tool, showDrawingView: $showDrawingView)
                    
                   case .none:
                       HomeViewController(showProfile: $showProfile, showContent: $showContent, viewState: $viewState)
                   }
               }
    }
}

// Update the extension on `View` to match the modified `ViewModifier`.
extension View {
    func sheetPresenter(activeSheet: Binding<ActiveSheet>,
                        arView: Binding<ARView>,
                        drawing: Binding<PKDrawing>,
                        showProfile: Binding<Bool>,
                        showContent: Binding<Bool>,
                        viewState: Binding<CGSize>,
                        showDrawingView: Binding<Bool>,
                        tool: Binding<PKTool>) -> some View {
        modifier(SheetPresenter(activeSheet: activeSheet,
                                arView: arView,
                                drawing: drawing,
                                tool: tool, 
                                showDrawingView: showDrawingView,
                                showProfile: showProfile,
                                showContent: showContent,
                                viewState: viewState))
    }
}
