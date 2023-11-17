//
//  ARViewContainer.swift
//  Hebro
//
//  Created by Hodaya Rosenberg on 8/10/23.
//

import SwiftUI
import ARKit
import RealityKit
import AVFoundation

func loadModel(in arView: ARView, for modelName: String) {
   
   
        if let url = Bundle.main.url(forResource: modelName, withExtension: "usdz") {
            loadAndAnchorEntity(from: url, in: arView, modelName: modelName)
        }
    
}

func loadAndAnchorEntity(from url: URL, in arView: ARView,modelName : String) {
    do {
        let loadedEntity = try Entity.load(contentsOf: url)
        
        
           // childEntity.scale = SIMD3<Float>(0.5, 0.5, 0.5)
       print( loadedEntity.availableAnimations)
        let anchor = AnchorEntity(plane: .horizontal,classification: .any)
        anchor.name = modelName
            anchor.addChild(loadedEntity)
            arView.scene.addAnchor(anchor)
        
        
    } catch {
        print("Error loading entity from \(url): \(error)")
    }
}
func removeAllEntities(from arView: ARView) {
    for anchor in arView.scene.anchors {
        arView.scene.removeAnchor(anchor)
    }
}
struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: ARView
    @Binding var modelNames: [String]
    @Binding var isSessionRunning: Bool
   
 
   

    func makeUIView(context: Context) -> ARView {
        configureARView()
        setupGestureRecognizers(for: arView, context: context)
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if isSessionRunning{
            print("update arviiew session true")
            if let configuration = uiView.session.configuration {
                uiView.session.run(configuration)
                print(configuration)
            } else {
                // Handle the error or set a default configuration
                print("error updating config")
            }
        } else {
            uiView.session.pause()
        }
    }


    private func configureARView() {
        // Ensure that ARWorldTrackingConfiguration is supported
        
        guard ARWorldTrackingConfiguration.isSupported else {
            print("ARWorldTrackingConfiguration is not supported.")
            return
        }
   
       
        // Enable debugging options
        arView.debugOptions = [.none/*.showFeaturePoints, .showWorldOrigin*/]
    }

    private func setupGestureRecognizers(for arView: ARView, context: Context) {
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTap(_:)))
        arView.addGestureRecognizer(tapRecognizer)
    }
   

    // MARK: Coordinator for handling interactions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var container: ARViewContainer
        var selectedWord: String?
        var speachFeature = SpeachFeature()
        
        init(_ container: ARViewContainer) {
            self.container = container
        }

        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            guard let arView = sender.view as? ARView else { return }

            let location = sender.location(in: arView)
            
            // Create a raycast query for entity hits
            if let query = arView.makeRaycastQuery(from: location, allowing: .existingPlaneGeometry, alignment: .any) {
                let results = arView.session.raycast(query)
                
                // If we hit an entity, handle it
                if let firstResult = results.first, let hitAnchor = firstResult.anchor {
                    for anchorEntity in arView.scene.anchors where anchorEntity.anchorIdentifier == hitAnchor.identifier {
                        
                        // Print the name of the AnchorEntity
                        print("AnchorEntity name: \(anchorEntity.name)")
                        self.selectedWord = anchorEntity.name
                        
                        // Handle the selected word
                        handleSelectedWord( selectedWord)
                        
                        break
                    }
                }
            }
        }
        
        func handleSelectedWord(_ selectedWord : String?) {
            if let word = selectedWord {
                speachFeature.pronunciationOfWord(word)
                print("Selected word: \(word)")
                
            }else{print("Debug Error: Selected word is nil")}
        }






    }
}

//#Preview {
//    ARContentView()
//}

