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

// Where the logic will be. There are 2 buttons. To add choose how many screens they want. They can increment and decrement
class ARViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var numberOfScreens: UILabel!
    
    var counter = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.numberOfScreens.text = "1"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let configeration = ARWorldTrackingConfiguration()
        sceneView.session.run(configeration)
        
    } 
    
    @IBAction func incrementButton(_ sender: Any) {
        if counter <= 5 {
            counter += 1
            self.numberOfScreens.text = String(counter)

        }
        let rect = CGRect(x: 40, y: 80, width: 400, height: 400)
        var webView: UIWebView! = UIWebView(frame: rect)

        DispatchQueue.main.async {
            //creates webView node
            self.view.addSubview(webView!)
            
            //creates the plane where the screen will be displayed
            let displayPlane = SCNPlane(width: 0.5,height: 0.3)
            
//James, ignore this
//**********//Trying to initialize plane from custom screen**********
//            let displayPlane = SCNScene(named: "SceneKit Asset Catalog.scnassets/SceneKit Scene.scn")
            //^ top replaced bottom v

            let webUrl : NSURL = NSURL(string: "https://google.com")!
            let request : NSURLRequest = NSURLRequest(url: webUrl as URL)

            webView.loadRequest(request as URLRequest)
            
            //projects the contents of the webView onto the plane
            displayPlane.firstMaterial?.diffuse.contents = webView
            
            //creates nodeø
            let webScreen = SCNNode(geometry: displayPlane)
            
            //puts screen where camera is facing
            let cc = self.getCameraCoordinates(sceneView: self.sceneView)

            //places the screen where the camera is facing, z axis is altered to push screen back
            webScreen.position = SCNVector3(cc.x, cc.y, cc.z - 0.75)
                                    
            self.sceneView.scene.rootNode.addChildNode(webScreen)

        }
        
    }
    
    @IBAction func decrementButton(_ sender: Any) {
        if counter >= 2 {
            counter -= 1
            self.numberOfScreens.text = String(counter)

        }

    }
    
    //variables with view location data
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
        
    }
    
    //call this function to get current location * other transformation code
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
        
         //tilts the plane from a horizontal to vertical position
        //            webScreen.eulerAngles.x = -.pi / 2
        
    }
    
}
