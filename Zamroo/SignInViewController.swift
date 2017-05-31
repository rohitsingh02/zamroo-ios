//
//  SignInViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 10/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SignInViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var emailTextField: DesignableTextField!
    
    
    @IBOutlet var passwordTextField: DesignableTextField!
    
    var email = ""
    var password = ""
    
    var statusString = ""
    var msgString = ""
    var userObjectJSON : JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func loginButton(_ sender: AnyObject) {
        email = emailTextField.text!
        password = passwordTextField.text!
        print(email)
        if emailTextField.text == nil{
           StringHelper.showAlert(msg: "Please Enter Email Id",msgSub: "")
        }
        else if passwordTextField.text == nil{
          StringHelper.showAlert(msg: "Please Enter Password",msgSub: "")
        }
        else{
        
            AppService.attemptLogin(AppService.signInUrl,email: email,password: password){
                (JSON) -> () in
                print(JSON)
                self.statusString = JSON["status"].stringValue
                self.msgString = JSON["msg"].stringValue
                
                if self.statusString == "Success"{
                    self.userObjectJSON = JSON["login_detail"]
                    
                    LocalStore.saveUserApiKey(self.userObjectJSON[0]["apikey"].stringValue)
                    print(JSON)
                    self.prepareSegueHelper()
                }
                else{
                  
                    StringHelper.showAlert(msg: "Unable to login!!",msgSub: "Please check your email and password.")
                }
            }
        }
    }
    
    func prepareSegueHelper(){
          LocalStore.saveAlreadyLogin(true)
          performSegue(withIdentifier: "loginSuccessfulSegue", sender: self)
    }
    
    @IBAction func facebookButton(_ sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email","user_friends"], from: self) { (result, error) -> Void in
            
            if (error == nil){
                
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
//              print(result)
                if (result?.isCancelled)! {
                    
                    return
                    
                }
                
                
                if(fbloginresult.grantedPermissions.contains("email"))
                    
                {
                    print("hello")
                    //
                 
                }
                
            }
            
        }
    
    }
    
    // Present a view that prompts the user to sign in with Google
    
    // Dismiss the "Sign in with Google" view

    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        
        return true
        
    }
    

    
    @IBAction func googleButton(_ sender: AnyObject) {
       
//         GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func forgotPassword(_ sender: AnyObject) {
      performSegue(withIdentifier: "ForgotPasswordSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSuccessfulSegue" {
            let destinationVc = segue.destination as! MyAccountViewController
            destinationVc.userObjectJSON = self.userObjectJSON
            
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)

    }
    
    
}
