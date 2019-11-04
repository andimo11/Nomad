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
class ARViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var numberOfScreens: UILabel!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var uiImplementView: UIView!
    
    var counter = 1
    var alreadyClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.numberOfScreens.text = "1"
        urlTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let configeration = ARWorldTrackingConfiguration()
        sceneView.session.run(configeration)
        uiImplementView.isHidden = true
    }
    
    
//    *********** So renderer and tapped is for the same function as implmenting a new screen?
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
            let location = sender.location(in: sender.view)
            guard let hitTestResult = sceneView.hitTest(location, types: [.existingPlaneUsingGeometry, .estimatedVerticalPlane]).first,
                  let planeAnchor = hitTestResult.anchor as? ARPlaneAnchor,
                  planeAnchor.alignment == .vertical else { return }
            let anchor = ARAnchor(transform: hitTestResult.worldTransform)
            self.sceneView.session.add(anchor: anchor)
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
//      ************ Alex, let's put this in a function? Considering we are reusing code?**************
        
        let rect = CGRect(x: 40, y: 80, width: 400, height: 400)
        var webView: UIWebView! = UIWebView(frame: rect)
        let webUrl : NSURL = NSURL(string: "https://google.com")!
        let request : NSURLRequest = NSURLRequest(url: webUrl as URL)

        //creates webView node
        self.view.addSubview(webView!)

        //creates the plane where the screen will be displayed
        let displayPlane = SCNPlane(width: 0.5,height: 0.3)

        webView.loadRequest(request as URLRequest)

        //projects the contents of the webView onto the plane
        displayPlane.firstMaterial?.diffuse.contents = webView

        //creates nodeø
        let webScreen = SCNNode(geometry: displayPlane)
      
        webScreen.eulerAngles = SCNVector3(CGFloat.pi * -0.5, 0.0, 0.0)
        
        return webScreen
    }

    
    @IBAction func decrementButton(_ sender: Any) {
        if counter >= 2 {
            counter -= 1
            self.numberOfScreens.text = String(counter)
        }
    }
    
    
        
    @IBAction func incrementButton(_ sender: Any) {
        if counter <= 5 {
            counter += 1
            self.numberOfScreens.text = String(counter)

        }
        // Former action is now in uiImplementView for users to fill out their url
        uiImplementView.isHidden = false

    }
    
    @IBAction func createARView(_ sender: Any) {
        // Put action in separate method for same action with return button too
        forButtonClick()
        alreadyClicked = false
    }
    
    
    @IBAction func getRidOfView(_ sender: Any) {
        uiImplementView.isHidden = true
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

//    variables with view location data
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if !alreadyClicked {
            forButtonClick()
        }
        return true;
    }
    
    private func forButtonClick() {
        uiImplementView.isHidden = true
        let givenUrl = "https://" + (urlTextField.text ?? "google.com")
        
        let rect = CGRect(x: 40, y: 80, width: 400, height: 400)
        let webView: UIWebView! = UIWebView(frame: rect)

        DispatchQueue.main.async {
            //creates webView node
            self.view.addSubview(webView!)

            //creates the plane where the screen will be displayed
            let displayPlane = SCNPlane(width: 0.5,height: 0.3)

//James, ignore this
//**********//Trying to initialize plane from custom screen**********
//            let displayPlane = SCNScene(named: "SceneKit Asset Catalog.scnassets/SceneKit Scene.scn")
            //^ top replaced bottom v

            let webUrl : NSURL = NSURL(string: givenUrl)!
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
}



