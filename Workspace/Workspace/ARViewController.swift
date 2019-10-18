//
//  ViewController.swift
//  Workspace
//
//  Created by James touri and Alexander Dimopoulos on 9/9/19.
//  Copyright © 2019 jamestouri and alexanderdimopoulos. All rights reserved.
//

import UIKit
import ARKit
import WebKit
import SpriteKit

// Where the logic will be. There are 2 buttons. To add choose how many screens they want. They can increment and decrement
class ARViewController: UIViewController {

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

        //creates webView node
        var webView: UIWebView!
        //creates the plane where the screen will be displayed
        let displayPlane = SCNPlane(width: 0.7,height: 0.5)
        
        //UIWebView.loadRequest(webView)(NSURLRequest(URL: NSURL(string: //"https://www.jpl.nasa.gov")!))
        let url = URL(string: "https://www.jpl.nasa.gov")
        let request = URLRequest(url: url!)
        
       //******* tried unwrapping here ******* remove ! if crashes
         webView.loadRequest(request!)
       //******************************

        self.view .addSubview(webView)
        //projects the contents of the webView onto the plane
        displayPlane.firstMaterial?.diffuse.contents = webView
        //creates node
        let webScreen = SCNNode(geometry: displayPlane)
        //tilts the plane from a horizontal to vertical position
        webScreen.eulerAngles.x = -.pi / 2
        sceneView.scene.rootNode.addChildNode(webScreen)
        
        //puts screen where camera is facing
        let cc = getCameraCoordinates(sceneView: sceneView)
        webScreen.position = SCNVector3(cc.x, cc.y, cc.z)
        
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
    
    //call this function to get current location
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
        
    }
    
}

////communicate between webView and arKit for browser manipulation
//protocol UIWebViewDelegate{
//    requirement
//}
