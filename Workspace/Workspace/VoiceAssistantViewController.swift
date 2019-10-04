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

class VoiceAssistantViewController: UIViewController, AVAudioPlayerDelegate, AIAuthenticationDelegate {
    
    let lwa = LoginWithAmazonProxy.sharedInstance
    
    private let recorder = AVAudioRecorder()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lwa.login(delegate: self)
        
    }
    
    
    @IBAction func loginWithAmazon(_ sender: Any) {
       lwa.login(delegate: self)
    }
    
    func getAccessToken(delegate: AIAuthenticationDelegate) {
        lwa.getAccessToken(delegate: self)
    }
    
    func requestDidSucceed(_ apiResult: APIResult) {
         switch(apiResult.api) {
         case API.authorizeUser:
                    print("Authorized")
                    getAccessToken(delegate: self)
         default:
             return
         }
     }
    
    func requestDidFail(_ errorResponse: APIError) {
        print("Error: \(String(describing: errorResponse.error.message))")
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
