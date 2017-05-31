//
//  SubmitAdViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 26/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SubmitAdViewController: UIViewController {

    var parameters = [String:AnyObject]()
    
    @IBOutlet var nameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var mobileNoTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var emailTextField: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func locationButtonDidTapped(_ sender: AnyObject) {
        performSegue(withIdentifier: "SubmitAdToSelectCitySegue", sender: self)

    }
 
    
    @IBAction func submitButtonDidTapped(_ sender: AnyObject) {
        
        for (theKey,_) in parameters{
            if theKey == "first_name"{
             parameters.updateValue(nameTextField.text! as AnyObject, forKey: theKey)
                
            }
            if theKey == "email"{
                parameters.updateValue(emailTextField.text! as AnyObject, forKey: theKey)
            }
            if theKey == "mobile_no"{
                parameters.updateValue(mobileNoTextField.text! as AnyObject, forKey: theKey)
            }
            if theKey == "landmark"{
                parameters.updateValue(LocalStore.getCityName()! as AnyObject, forKey: theKey)

            }
        }
        print(parameters)
    
        func confirmationPage(){
            performSegue(withIdentifier: "AdConfirmationSegue", sender: self)

        }
        
        AppService.postAdDataToUrl(AppService.postFreeAdsUrl, parameters: parameters){
         (JSON) -> () in
            
            if JSON == "success"{
              confirmationPage()
            }
        }
    }
}
