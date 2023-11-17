//
//  ScrollViewComponent.swift
//  LiduLounge
//
//  Created by Hodaya Rosenberg on 8/14/23.
//

import SwiftUI
import ARKit
import RealityKit
/// is the scroll view that displayes the USDZ files and is overlayed in ARViewController..
struct ScrollViewARModels: View {
    @Binding var arView: ARView
    @Binding var modelNames : [String]
    @Binding var selectedModel : String
    @Binding var isModelTapped : Bool

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(modelNames, id: \.self) { modelName in
                    Button(action: {
                        print("model tapped")
                        selectedModel = modelName
                        //debug use
                        print("\(selectedModel)")
                        isModelTapped = true 
                        
                     //   DispatchQueue.main.async {
                         
                           //  Clear all existing entities
                            
                            removeAllEntities(from: arView)
                            // Load specific model tapped
                            loadModel(in: arView, for: modelName)
                      //  }
                    }) {
//                        Image( "model\(index)" )
                        Image(modelName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 35)  )
                            
                    }
                  
                }
            }
        }
    }




}


#Preview {
    ScrollViewARModels(arView : .constant(ARView(frame: .zero)), modelNames:.constant(["Guitar"]), selectedModel: .constant("Guitar"), isModelTapped: .constant(false))
}
