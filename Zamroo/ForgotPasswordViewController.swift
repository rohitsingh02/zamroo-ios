//
//  ForgotPasswordViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 11/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class ForgotPasswordViewController: UIViewController {

    
    @IBOutlet var emailTextField: DesignableTextField!
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendMePasswordResetLinkButton(_ sender: AnyObject) {
        email = emailTextField.text!
        
        AppService.attemptPasswordReset(AppService.forgotPasswordUrl,email: email){
        (JSON) -> () in
        
          //password reset link sent to your email
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
    }

}
