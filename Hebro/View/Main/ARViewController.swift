//
//  ARViewController.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 10/25/23.
//

import SwiftUI
import RealityKit
import ARKit
import AVFoundation
struct ARViewController: View {
    
    @State var modelNames = ["Shoe", "Robot", "Guitar"] // Add more model names as needed
    @Binding var activeSheet: ActiveSheet
    @Binding var arView : ARView
    @State private var isSessionRunning: Bool = true
    @State var isModelTapped = false
    @State var selectedModel : String = " "
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ARViewContainer(arView: $arView, modelNames : $modelNames, isSessionRunning: $isSessionRunning)
                    .onAppear{
                        isSessionRunning = true
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                // Ignore safe area for AR view
                    .overlay {
                        ScrollViewARModels(arView: $arView, modelNames: $modelNames, selectedModel: $selectedModel, isModelTapped: $isModelTapped )
                            .padding() // Add padding around the ScrollView
                            .background(.white.opacity(0.5)) // Add a background color
                            .position(x: geometry.size.width / 2, y: geometry.size.height - 50) // Position at the bottom
                    }
                //text label overlay
                    .overlay(
                        VStack {
                            Text( isModelTapped ? "tap the \(selectedModel) to listen in Hebrew":"Tap an item to start exploring")
                                .fontWeight(.thin)
                                .foregroundColor(.black.opacity(0.75))
                            
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(.thinMaterial)
                                .cornerRadius(10)
                                .offset(y: 60)
                                .padding() // This adds padding around the entire Text view
                            Spacer() // Pushes the label to the top
                        },
                        alignment: .top // Aligns the VStack to the top of the overlaying view
                    )
                
                
                
                
                
                
                
                
                
                // "x" Mark Button
                
                VStack {
                    HStack {
                        Button(action: {
                            
                            // Pause AR session
                            isSessionRunning = false
                            // Upadate the activeSheet
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
                        .offset(y: 20)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        
        
    }
    
}



//#Preview {
//    ARViewController()
//}
