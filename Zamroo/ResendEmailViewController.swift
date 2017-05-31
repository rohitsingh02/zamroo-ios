//
//  ResendEmailViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 10/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class ResendEmailViewController: UIViewController {

    
    @IBOutlet var emailLabel: UILabel!
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()

       emailLabel.text = email
        
    }

    
    
}
