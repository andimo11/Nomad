//
//  ViewController.swift
//  Workspace
//
//  Created by James touri on 9/9/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit
import ARKit

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
        self.numberOfScreens.text = String(counter)
    }
    
    
    @IBAction func incrementButton(_ sender: Any) {
        counter += 1

    }
    
    @IBAction func decrementButton(_ sender: Any) {
        counter -= 1
    }
    
}

