//
//  MinigamesSceneViewRepresentable.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import SwiftUI
import SceneKit
import ARKit
import CoreML
import Vision

struct MinigamesSceneViewRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<MinigamesSceneViewRepresentable>) -> ViewController {
        let sceneView = ARSKView(frame: .zero)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<MinigamesSceneViewRepresentable>) {
        // Update the view controller if needed
    }
}

