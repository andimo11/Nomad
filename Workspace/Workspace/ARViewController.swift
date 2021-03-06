//
//  ViewController.swift
//  Workspace
//
//  Created by James touri and Alexander Dimopoulos on 9/9/19.
//  Copyright © 2019 jamestouri & alexanderdimopoulos. All rights reserved.
//

import UIKit
import ARKit
import WebKit
import SpriteKit
import GoogleSignIn

// Where the logic will be. There are 2 buttons. To add choose how many screens they want. They can increment and decrement
class ARViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    var alreadyClicked = false
    
    // URLs received in the 
    var inputUrls: [String] = []
    
    // Store the coordinates for the next coming node. Want to add logic if we remove one
    var nextNodeCoordinates: [Float] = []
    
    // To determine if we can create screens. We only want to create screens first
    var noScreens = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addTapGestureToSceneView()

    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let configeration = ARWorldTrackingConfiguration()
        sceneView.session.run(configeration)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (noScreens) {
          
            guard let touch = touches.first else {return}
            let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
            guard let hitResult = result.last else {return}
            
            let adjustments = displayLayOut(numScreens: inputUrls.count)
            
            for i in 0...(inputUrls.count - 1) {
                let hitTransform = SCNMatrix4.init(hitResult.worldTransform)
            
                // If empty we store node based on touch
                if nextNodeCoordinates.isEmpty {
                    var hitVectorFirst = SCNVector3Make(hitTransform.m41, hitTransform.m42, hitTransform.m43)
                    hitVectorFirst.z -= 0.75
                    
                    // append the coordinates to store them
                    nextNodeCoordinates.append(hitVectorFirst.x)
                    nextNodeCoordinates.append(hitVectorFirst.y)
                    nextNodeCoordinates.append(hitVectorFirst.z)
                    
                    createScreen(position: hitVectorFirst, url: inputUrls[i], adjust: adjustments[i])
                    
                } else {
                    // If the array is not empty we add a monitor right next to it
                    print(nextNodeCoordinates)
                    print("\n\n\n\n")
                    let hitVectorAdjusted = SCNVector3Make(nextNodeCoordinates[0] + 0.5, nextNodeCoordinates[1], nextNodeCoordinates[2])
                    
                    nextNodeCoordinates[0] += 0.5
                    
                    createScreen(position: hitVectorAdjusted, url: inputUrls[i], adjust:
                    adjustments[i])
                }
            }
            
            noScreens = false
        }
        
    }
    
    func createScreen(position: SCNVector3, url: String, adjust: Array<Int>) {
        DispatchQueue.main.async {
            let rect = CGRect(x: 40, y: 80, width: 400, height: 400)
            let webView: UIWebView! = UIWebView(frame: rect)
            self.view.addSubview(webView!)
            let displayPlane = SCNPlane(width: 0.5,height: 0.3)
            let webUrl : NSURL = NSURL(string: url)!
            let request : NSURLRequest = NSURLRequest(url: webUrl as URL)
            webView.loadRequest(request as URLRequest)
            displayPlane.firstMaterial?.diffuse.contents = webView
            let webScreen = SCNNode(geometry: displayPlane)
            webScreen.position = position
            webScreen.lookAt(SCNVector3(adjust[0], adjust[1], adjust[2]))
            webScreen.name = "webscreen"
            self.sceneView.scene.rootNode.addChildNode(webScreen)
        }
    }
        
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.last?.node else { return }
        node.removeFromParentNode()
    }
        
//    call this function to get current location * other transformation code
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        return cc
    }

//  variables with view location data
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    @IBAction func signOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
}

extension Float {
    /// Convert degrees to radians
    func asRadians() -> Float {
        return self * Float.pi / 180
    }
}

extension SCNNode {
    /// Look at a SCNVector3 point
    func lookAt(_ point: SCNVector3) {
        if point.x != 0 {
            // Find change in positions
            let changeX = self.position.x - point.x // Change in X position
            let changeY = self.position.y - point.y // Change in Y position
            let changeZ = self.position.z - point.z // Change in Z position

            // Calculate the X and Y angles
            let angleX = atan2(changeZ, changeY) * (changeZ > 0 ? -1 : 1)
            let angleY = atan2(changeZ, changeX)

            // Calculate the X and Y rotations
            let xRot = Float(-90).asRadians() - angleX // X rotation
            let yRot = Float(90).asRadians() - angleY // Y rotation
            self.eulerAngles = SCNVector3(CGFloat(xRot), CGFloat(yRot), 0) // Rotate
        }
        else {return}
    }
}
