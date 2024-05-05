//
//  SceneMini.swift
//  Fishy Friends
//
//  Created by Jasmine Mutia Alifa on 05/05/24.
//

import SpriteKit
import ARKit

class SceneMini: SKScene {

    var startTime: Date?
    var timer: Timer?
    var ghostTaken = 0
        
    let ghostsLabel = SKLabelNode(text: "Fish")
    let numberOfGhostsLabel = SKLabelNode(text: "0")
    var creationTime : TimeInterval = 0
    var ghostCount = 0 {
        didSet{
            self.numberOfGhostsLabel.text = "\(ghostCount)"
        }
    }
    
    let killSound = SKAction.playSoundFileNamed("ghost", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        ghostsLabel.fontSize = 20
        ghostsLabel.fontName = "DevanagariSangamMN-Bold"
        ghostsLabel.color = .white
        ghostsLabel.position = CGPoint(x: 40, y: 50)
        addChild(ghostsLabel)
        
        numberOfGhostsLabel.fontSize = 30
        numberOfGhostsLabel.fontName = "DevanagariSangamMN-Bold"
        numberOfGhostsLabel.color = .white
        numberOfGhostsLabel.position = CGPoint(x: 40, y: 10)
        addChild(numberOfGhostsLabel)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if currentTime > creationTime && ghostCount < 20 {
            createGhostAnchor()
            creationTime = currentTime + TimeInterval(randomFloat(min: 3.0, max: 6.0))
            
            print(ghostTaken)

            if ghostTaken >= 10 {
                timer?.invalidate()
                let timePassed = Int(Date().timeIntervalSince(startTime!))

                // trigger haptic feedback without creating a generator
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

                // present a modal view controller with "Game Over" and the time passed
                let alertController = UIAlertController(title: "Game Over", message: "You took \(timePassed) seconds to take 10 ghosts", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    // go to ContentView
                    if let viewController = self.view?.window?.rootViewController {
                        viewController.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(action)
                if let viewController = self.view?.window?.rootViewController {
                    viewController.present(alertController, animated: true, completion: nil)
            }
        }
        }
    }
    
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
    
    func createGhostAnchor(){
        guard let sceneView = self.view as? ARSKView else {
            return
        }

        if startTime == nil {
            startTime = Date()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                let timePassed = Int(Date().timeIntervalSince(self.startTime!))
                self.ghostsLabel.text = "Fish"
            })
        }
        
        // Define 360º in radians
        let _360degrees = 2.0 * Float.pi
        
        // Create a rotation matrix in the X-axis
        let rotateX = simd_float4x4(SCNMatrix4MakeRotation(_360degrees * randomFloat(min: 0.0, max: 1.0), 1, 0, 0))
        
        // Create a rotation matrix in the Y-axis
        let rotateY = simd_float4x4(SCNMatrix4MakeRotation(_360degrees * randomFloat(min: 0.0, max: 1.0), 0, 1, 0))
        
        // Combine both rotation matrices
        let rotation = simd_mul(rotateX, rotateY)
        
        // Create a translation matrix in the Z-axis with a value between 1 and 2 meters
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1 - randomFloat(min: 0.0, max: 1.0)
        
        // Combine the rotation and translation matrices
        let transform = simd_mul(rotation, translation)
        
        // Create an anchor
        let anchor = ARAnchor(transform: transform)
        
        // Add the anchor
        sceneView.session.add(anchor: anchor)

        // add haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        // Increment the counter
        ghostCount += 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get the first touch
        guard let touch = touches.first else {
            return
        }
        // Get the location in the AR scene
        let location = touch.location(in: self)
        
        // Get the nodes at that location
        let hit = nodes(at: location)
        
        // Get the first node (if any)
        if let node = hit.first {
            // Check if the node is a ghost (remember that labels are also a node)
            if node.name == "ghost" {
                let fadeOut = SKAction.fadeOut(withDuration: 0.5)
                let remove = SKAction.removeFromParent()
                
                // Group the fade out and sound actions
                let groupKillingActions = SKAction.group([fadeOut, killSound])
                // Create an action sequence
                let sequenceAction = SKAction.sequence([groupKillingActions, remove])
                
                // Excecute the actions
                node.run(sequenceAction)

                // add haptic feedback
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                
                // Update the counter
                ghostCount -= 1

                // update the score
                ghostTaken += 1
            }
            
        }
    }
}

