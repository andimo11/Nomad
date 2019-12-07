//
//  UrlInputViewController.swift
//  Workspace
//
//  Created by James touri on 12/6/19.
//  Copyright © 2019 jamestouri. All rights reserved.
//

import UIKit

class UrlInputViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func inputUrlButton(_ sender: Any) {
        self.performSegue(withIdentifier: "transferUrls", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "transferUrls") {
            let ARViewController = segue.destination as! ARViewController
            
        }
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
