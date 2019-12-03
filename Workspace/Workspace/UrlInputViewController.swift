//
//  UrlInputViewController.swift
//  Workspace
//
//  Created by James touri on 12/2/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit

class UrlInputViewController: UIViewController {

    @IBOutlet var urlTextInputs: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButton(_ sender: Any) {
    }
    
   func textFieldShouldReturn(textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
}
