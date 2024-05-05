//
//  SceneKitView.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import SwiftUI
import SceneKit
import ARKit
import CoreML
import Vision

struct SceneKitView: UIViewRepresentable {
    
    var index = 0
    
    let gifNames = ["Puffer Fish", "Puffer Eat", "Puffer Sleep", "Puffer Sick"]
    
    let arView = ARSCNView(frame: .zero)
    
    func makeUIView(context: Context) -> ARSCNView {
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        arView.scene.rootNode.addChildNode(addGIF(name: gifNames[index]))

        // add 3 custom buttons from image to change gif, "Puffer Eat", "Puffer Sleep", "Puffer Sick"
        let changeGifButton = UIButton()
        changeGifButton.setImage(UIImage(named: "Eat"), for: .normal)
        changeGifButton.addTarget(context.coordinator, action: #selector(Coordinator.changeGifButtonTapped), for: .touchUpInside)
        arView.addSubview(changeGifButton)

        let changeGifButton1 = UIButton()
        changeGifButton1.setImage(UIImage(named: "Sleep"), for: .normal)
        changeGifButton1.addTarget(context.coordinator, action: #selector(Coordinator.changeGifButtonTapped2), for: .touchUpInside)
        arView.addSubview(changeGifButton1)

        let changeGifButton2 = UIButton()
        changeGifButton2.setImage(UIImage(named: "Sick"), for: .normal)
        changeGifButton2.addTarget(context.coordinator, action: #selector(Coordinator.changeGifButtonTapped3), for: .touchUpInside)
        arView.addSubview(changeGifButton2)

        // add constraints to the buttons
        changeGifButton.translatesAutoresizingMaskIntoConstraints = false
        changeGifButton1.translatesAutoresizingMaskIntoConstraints = false
        changeGifButton2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeGifButton.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -16),
            changeGifButton.centerXAnchor.constraint(equalTo: arView.centerXAnchor),
            changeGifButton.widthAnchor.constraint(equalToConstant: 72),
            changeGifButton.heightAnchor.constraint(equalToConstant: 72),
            
            changeGifButton1.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -16),
            changeGifButton1.trailingAnchor.constraint(equalTo: changeGifButton.leadingAnchor, constant: -16),
            changeGifButton1.widthAnchor.constraint(equalToConstant: 72),
            changeGifButton1.heightAnchor.constraint(equalToConstant: 72),
            
            changeGifButton2.bottomAnchor.constraint(equalTo: arView.bottomAnchor, constant: -16),
            changeGifButton2.leadingAnchor.constraint(equalTo: changeGifButton.trailingAnchor, constant: 16),
            changeGifButton2.widthAnchor.constraint(equalToConstant: 72),
            changeGifButton2.heightAnchor.constraint(equalToConstant: 72)
        ])

        // for each 5 seconds, predict hand pose
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
//            self.predictHandPose()
//        }

        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        let arView = ARSCNView()
        arView.scene.rootNode.addChildNode(addGIF(name: gifNames[index]))
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: SceneKitView
        var isSleep = false

        init(_ parent: SceneKitView) {
            self.parent = parent
        }

        @objc func changeGifButtonTapped() {
            parent.changeGif(name: parent.gifNames[1])
            // for interval 8 seconds, change the gif to the former gif
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                self.parent.changeGif(name: self.parent.gifNames[0])
            }
        }

        @objc func changeGifButtonTapped2() {
            if !isSleep {
                parent.changeGif(name: parent.gifNames[2])
                isSleep = true
            } else {
                parent.changeGif(name: parent.gifNames[0])
                isSleep = false
            }
        }

        @objc func changeGifButtonTapped3() {
            parent.index = (parent.index + 1) % parent.gifNames.count
            parent.changeGif(name: parent.gifNames[3])
            // for interval 8 seconds, change the gif to the former gif
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
                self.parent.changeGif(name: self.parent.gifNames[0])
            }
        }
    }
    
    func setupScene(in arView: ARSCNView) {
        
    }
    
    func addGIF(name: String) -> SCNNode {
        let gifNode = SCNNode()
        
        let gifPlane = SCNPlane(width: 1, height: 1)
        let gifImage = UIImage.gifImageWithName(name)
        let gifImageView = UIImageView(image: gifImage)
        gifPlane.firstMaterial?.diffuse.contents = gifImageView
        
        gifNode.geometry = gifPlane
        gifNode.position = SCNVector3(0, 0, -1)
        return gifNode
    }
    
    func changeGif(name: String) {
            // Remove the old GIF node
            arView.scene.rootNode.childNodes.forEach { $0.removeFromParentNode() }

            // Add the new GIF node
            arView.scene.rootNode.addChildNode(addGIF(name: name))

            // Add haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
        }

//    func predictHandPose() {
//        guard let currentFrame = arView.session.currentFrame else {
//            return
//        }
//
//        let pixelBuffer = currentFrame.capturedImage
//
//        // convert pixelBuffer to multiArray
//        guard let multiArray = try? MLMultiArray(pixelBuffer: pixelBuffer, shape: [1, 3, 21]) else {
//            return print("Error converting pixelBuffer to multiArray")
//        }
//
//        // predict hand pose
//        guard let prediction = try? modelAr.prediction(from: HandPoseClfInput(poses: multiArray)) else {
//            return print("Error predicting hand pose")
//        }
//
//        print(prediction)
//        // switch gif based on pose
////        switch pose {
////        case "Food":
////            changeGif(name: "Puffer Eat")
////        case "Sick":
////            changeGif(name: "gif2")
////        case "Chill":
////            changeGif(name: "fish")
////        case "Play":
////            changeGif(name: "Puffer Eat")
////        default:
////            break
////        }
//    }
    
//    func predictActionFromWindow(_ window: MLMultiArray) -> String {
//        do {
//            let output = try prediction(poses: window)
//            let action = Label(output.label)
//            let confidence = output.labelProbabilities[output.label]!
//
//            return ActionPrediction(label: action.rawValue, confidence: confidence)
//
//        } catch {
//            fatalError("Exercise Classifier prediction error: \(error)")
//        }
//    }
    
    
}

