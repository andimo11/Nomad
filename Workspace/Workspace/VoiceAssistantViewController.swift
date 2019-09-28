//
//  VoiceAssistantViewController.swift
//  Workspace
//
//  Created by James touri on 9/17/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit
import AVFoundation
import LoginWithAmazon

class VoiceAssistantViewController: UIViewController, AVAudioPlayerDelegate {
    
    private let recorder = AVAudioRecorder()
    static let sharedInstance = LoginWithAmazonProxy()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func loginWithAmazon(_ sender: Any) {
        AIMobileLib.authorizeUser(forScopes: ["profile", "postal_code"], delegate: self as? AIAuthenticationDelegate)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
