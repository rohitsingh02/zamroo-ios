//
//  MyAccountViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 26/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class MyAccountViewController: UIViewController {

    @IBOutlet var myProfileView: DesignableView!
    
    
    @IBOutlet var myAdsView: DesignableView!
    
    
    @IBOutlet var myFavouritesView: DesignableView!
    
    @IBOutlet var postFreeAdView: DesignableView!
    
    
    @IBOutlet var contactUsView: DesignableView!
    
    
    @IBOutlet var logoutView: DesignableView!
    
    var userObjectJSON :JSON = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let myProfileViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(MyAccountViewController.myProfileViewTapped))
        myProfileView.addGestureRecognizer(myProfileViewTapGesture)
        
        let myAdsViewTapGesture = UITapGestureRecognizer(target: self, action:  #selector(MyAccountViewController.myAdsViewTapped))
        myAdsView.addGestureRecognizer(myAdsViewTapGesture)
        
        let myFavouritesViewTapGesture = UITapGestureRecognizer(target: self, action:  #selector(MyAccountViewController.myFavouriteViewTapped))
        myFavouritesView.addGestureRecognizer(myFavouritesViewTapGesture)
        
        let postFreeAdsView = UITapGestureRecognizer(target: self, action:  #selector(MyAccountViewController.postFreeAdsViewTapped))
        postFreeAdView.addGestureRecognizer(postFreeAdsView)
        
        let contactusView = UITapGestureRecognizer(target: self, action:  #selector(MyAccountViewController.contactUsViewTapped))
        contactUsView.addGestureRecognizer(contactusView)
        
        let logOutView = UITapGestureRecognizer(target: self, action:  #selector(MyAccountViewController.logoutViewTapped))
        logoutView.addGestureRecognizer(logOutView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func myProfileViewTapped(){
        performSegue(withIdentifier: "MyAccountToMyProfileSegue", sender: self)
    }
    
    func myAdsViewTapped(){
        
    }
    
    func myFavouriteViewTapped(){
        
        
    }
    
    func postFreeAdsViewTapped(){
        performSegue(withIdentifier: "MyAccountToPostAdSegue", sender: self)
    }
    
    func contactUsViewTapped(){
         performSegue(withIdentifier: "MyAccountToContactUsSegue", sender: self)
    }
    
    func logoutViewTapped(){
        LocalStore.saveAlreadyLogin(false)
        performSegue(withIdentifier: "LogoutSegue", sender: self)
    }

    
    

}
