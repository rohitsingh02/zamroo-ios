//
//  ContactUsViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 11/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import DropDown

class ContactUsViewController: UIViewController {

    @IBOutlet var selectDepartmentButton: UIButton!
    
    @IBOutlet var departmentLabel: UILabel!
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var mobileTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var messageTextField: UITextField!
    
    
     var selectedDepartment = ""
    
     let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        setupDropDown()
        dropDown.dismissMode = .onTap
        dropDown.direction = .any
        
        
        DropDown.setupDefaultAppearance()
 
    }

    
    
    func setupDropDown() {
       
        dropDown.anchorView = selectDepartmentButton
        dropDown.bottomOffset = CGPoint(x: 0, y: selectDepartmentButton.bounds.height)
        dropDown.dataSource = ["Select Department", "Advertising Opportunities", "Press","Support Team","Feedback About Zamroo","Others"]
        dropDown.selectionAction = { [unowned self] (index, item) in
            self.departmentLabel.text = item
            self.selectedDepartment = self.dropDown.selectedItem!
            self.dropDown.hide()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func selectDepartmentButtonTapped(_ sender: Any) {
        
       dropDown.show()
        
    }
    
 
    @IBAction func submitButtonClicked(_ sender: Any) {
        
     let name = nameTextField.text
     let email = emailTextField.text
     let mobile = mobileTextField.text
     let message = messageTextField.text
        
        if selectedDepartment != "" && name != nil && email != nil && mobile != nil && message != nil{
        
            //post data
            
        }
        
     }
    

}
