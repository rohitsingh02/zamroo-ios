//
//  MyProfileViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 10/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButton(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
