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

// Where the logic will be. There are 2 buttons. To add choose how many screens they want. They can increment and decrement
class ARViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var numberOfScreens: UILabel!
    
    var counter = 1
    
   override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.numberOfScreens.text = "1"
        let webConfiguration = WKWebViewConfiguration()
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 640, height: 480), configuration: webConfiguration)
        view = webView
        webView.uiDelegate = self

        webView.load(myRequest)

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
        let webScreen = SCNPlane(width: 0.7,height: 0.5)
        webScreen.firstMaterial?.diffuse.contents = self.webView
        let webScreenNode = SCNNode(geometry: webScreen)
        webScreenNode.eulerAngles.x = -.pi / 2
        node.addChildNode(webScreenNode)
        
        //puts screen where camera is facing
        let cc = getCameraCoordinates(scenceView: sceneView)
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

