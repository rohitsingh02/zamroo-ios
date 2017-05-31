//
//  LoginOrSignUpViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 10/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class LoginOrSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if LocalStore.getAlreadyLogin() == true {
          performSegue(withIdentifier: "LoginToMyAccountSegue", sender: self)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
