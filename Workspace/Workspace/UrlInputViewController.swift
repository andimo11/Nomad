//
//  UrlInputViewController.swift
//  Workspace
//
//  Created by James touri on 12/6/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit

class UrlInputViewController: UIViewController {

    @IBOutlet var urlInputFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputUrlButton(_ sender: Any) {
        self.performSegue(withIdentifier: "transferUrls", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "transferUrls") {
            var urlTexts: [String] = []
            let ARViewController = segue.destination as! ARViewController
            for urlField in urlInputFields {
                if urlField.text != "" {
                    urlTexts.append("https://" + urlField.text!)
                }
            }
            ARViewController.inputUrls = urlTexts
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
