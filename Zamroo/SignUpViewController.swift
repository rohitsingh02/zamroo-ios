//
//  SignUpViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 10/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController
{
    
    @IBOutlet var emailTextField: DesignableTextField!
    
    @IBOutlet var passswordTextField: DesignableTextField!
    
    @IBOutlet var confirmPasswordTextField: DesignableTextField!
    
    var statusString = ""
    var msgString = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButton(_ sender: AnyObject) {
        
        email = emailTextField.text!
        password = passswordTextField.text!
        confirmPassword = confirmPasswordTextField.text!
        
        if email.length == 0 || password.length == 0  || confirmPassword.length == 0  {
         StringHelper.showAlert(msg: "Please Fill Credentials.",msgSub: "")
        }else{
         self.sendDataForSignUp()
        }
    }


    @IBAction func facebookButton(_ sender: AnyObject) {
        
    }
    
    
    @IBAction func googleButton(_ sender: AnyObject) {
        
    }
    
    
    
    
 func sendDataForSignUp(){
    
    AppService.sendDataToUrl(AppService.signUpUrl, email: self.email, password: self.password, confirmPassword: self.confirmPassword){
        (JSON) -> () in
        
        self.statusString = JSON["status"].stringValue
        self.msgString = JSON["msg"].stringValue
        
        if self.statusString == "Success"{
         self.callSegue()
        }else{
          
          StringHelper.showAlert(msg: "Enteries Not Correct",msgSub: "Please verify username and password")
        }
    }
 }

    func callSegue(){
        performSegue(withIdentifier: "ResendEmail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResendEmail"{
        let destinationVc = segue.destination as!
            ResendEmailViewController
         destinationVc.email = self.email
        }
    }
    
    
    
    

}
