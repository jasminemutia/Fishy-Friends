//
//  ViewController.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        if let sceneView = sceneView {
            sceneView.delegate = self
            
            // Show statistics such as fps and node count
            sceneView.showsFPS = true
            sceneView.showsNodeCount = true
            
            let scene = SceneMini(size: sceneView.bounds.size)
            scene.scaleMode = SKSceneScaleMode.resizeFill
            sceneView.presentScene(scene)
            
            let overlayView = UIView(frame: sceneView.bounds)
            overlayView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
            sceneView.addSubview(overlayView)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        //configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView?.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView?.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        let ghostId = randomInt(min: 1, max: 4)
        
        let node = SKSpriteNode(imageNamed: "fish\(ghostId)")
        node.name = "ghost"
        
        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

