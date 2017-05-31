//
//  MoreViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 26/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class PoliciesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarView: UIView = UIView(frame: StringHelper().CGRectMake(0.0, 0.0, UIScreen.main.bounds.width, 20.0))
        statusBarView.backgroundColor = UIColor(colorLiteralRed: 9.0/255.0, green: 54.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        view.addSubview(statusBarView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func termOfUseButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func privacyPolicyButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func infringementPolicyButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func disclaimersButtonTapped(_ sender: AnyObject) {
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
}
