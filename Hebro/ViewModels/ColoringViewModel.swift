//
//  ColoringViewModel.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 10/4/23.
//



import SwiftUI
import PencilKit

struct ColoringViewModel: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    @Binding var tool: PKTool
   
    
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.isUserInteractionEnabled = true
        canvasView.delegate = context.coordinator
        canvasView.drawing = drawing
        canvasView.tool = tool
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        canvasView.drawing = drawing
        canvasView.tool = tool

        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: ColoringViewModel
        
        init(_ parent: ColoringViewModel) {
            self.parent = parent
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            DispatchQueue.main.async {
                self.parent.drawing = canvasView.drawing
            }
        }

        func canvasView(_ canvasView: PKCanvasView, shouldShowEditMenuAt point: CGPoint) -> Bool {
            return false
        }
    }

}

