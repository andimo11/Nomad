//
//  UrlInputViewController.swift
//  Workspace
//
//  Created by James touri on 12/2/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit

class UrlInputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var urlTextInputs: [UITextField]!
    var textInputs: [String?] = []
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func transferDataButton(_ sender: Any) {
        self.performSegue(withIdentifier: "passData", sender: self)
        for url in urlTextInputs {
            if url.text != "" {
                count += 1
            }
            textInputs.append("https://" + url.text!)
        }
        
        var urlInputs = MonitorSet(
            numberOfMonitors: count,
            websites: textInputs as! [String]
        )
      
    }
    
    
}
