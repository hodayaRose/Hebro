//
//  ToolPicker.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 10/4/23.
//

import SwiftUI
import PencilKit



struct ToolPicker: UIViewRepresentable {
    @Binding var tool: PKTool
    @Binding var drawing: PKDrawing
    
    private let toolPicker = PKToolPicker()
    var backgroundImage = UIImage(named: "\(K.Images.alef)")
    
    func makeUIView(context: Context) -> PKCanvasView{
        let canvasView = PKCanvasView()
        canvasView.delegate = context.coordinator
        canvasView.drawing = drawing
        canvasView.tool = tool
        
        // Set the background image if available
        if let backgroundImage {
            let imageView = UIImageView(image: backgroundImage)
            imageView.contentMode = .scaleAspectFill
            
            
            // This is equivalent to SwiftUI's .aspectRatio(contentMode: .fit)
            
            // Add the imageView to canvasView
            imageView.frame = canvasView.bounds
            imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            imageView.isUserInteractionEnabled = false
            canvasView.addSubview(imageView)
            canvasView.sendSubviewToBack(imageView)
            canvasView.layer.cornerRadius = 60
            canvasView.clipsToBounds = true
            canvasView.layer.masksToBounds = true
            
            
            // ensure the canvasView's background doesn't show through
            canvasView.backgroundColor = .clear
        }
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        if let canvasView = canvasView as? PKCanvasView {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(context.coordinator)
            canvasView.becomeFirstResponder()
            
            canvasView.drawing = drawing
            canvasView.tool = tool
            //context.coordinator.parent.backgroundImage = backgroundImage
            
        }
    }
    
    func makeCoordinator() -> ToolPickerCoordinator {
        ToolPickerCoordinator(self, tool: $tool,drawing: $drawing)
    }
}
//coordinator
class ToolPickerCoordinator: NSObject, PKToolPickerObserver ,PKCanvasViewDelegate{
    var parent: ToolPicker
    @Binding var tool: PKTool
    @Binding var drawing: PKDrawing
    
    init(_ parent: ToolPicker , tool: Binding<PKTool>,drawing: Binding<PKDrawing>) {
        self.parent = parent
        _tool = tool // Initialize the tool binding
        _drawing = drawing
    }
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        DispatchQueue.main.async {
            self.parent.drawing = canvasView.drawing
        }
    }
    
    func canvasView(_ canvasView: PKCanvasView, shouldShowEditMenuAt point: CGPoint) -> Bool {
        return false
    }
    // MARK: - PKToolPickerObserver Methods
    
    // Called when the selected tool in the tool picker changes
    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
        tool = toolPicker.selectedTool
    }
    
    // Called when the tool picker's visibility changes
    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        // Handle visibility change, e.g., update a state variable
    }
    
    // Called when the tool picker's frame (position) changes
    private func toolPickerFrameObscuredDidChange(_ toolPicker: PKToolPicker) {
        // Handle frame change, e.g., adjust UI elements to avoid being obscured
    }
    
    // Called when the ruler's active state in the tool picker changes
    func toolPickerIsRulerActiveDidChange(_ toolPicker: PKToolPicker) {
        // Handle ruler active state change, e.g., update a state variable
    }
    
    // Called when the tool picker's UI style changes (light/dark mode)
    func toolPickerDidChangeUserInterfaceStyle(_ toolPicker: PKToolPicker) {
        // Handle UI style change, e.g., adjust custom UI elements to match the new style
    }
    
    // Called when the tool picker's UI layout changes (e.g., due to device rotation)
    func toolPickerDidChangeLayoutDirection(_ toolPicker: PKToolPicker) {
        // Handle layout direction change, e.g., adjust UI layout
        print("layout has changed, device rotated")
    }
    
    // MARK: - PKCanvasViewDelegate Methods
    
    
}




