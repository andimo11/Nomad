//
//  SIgnInViewController.swift
//  Workspace
//
//  Created by James touri on 11/6/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit
import GoogleSignIn

class SIgnInViewController: UIViewController {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
}
