//
//  Phone&TabletViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 06/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class SubCategoriesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var category:JSON = [:]
    var subCategoryId:Int = 0
    var subCategoryName = ""
    var image = ""
    var isSeguedForViewAllAds = false

    @IBOutlet var subCategoryBannerImageView: UIImageView!
    
    @IBOutlet var navBarTitle: UINavigationItem!
    
    @IBOutlet var subCategoriesTableView: UITableView!
    
    @IBOutlet var backBarButtonItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        self.subCategoriesTableView.delegate = self
        self.subCategoriesTableView.dataSource = self
        self.subCategoriesTableView.tableFooterView = UIView()
        
        self.navBarTitle.title = category["category_name"].stringValue
        
        let statusBarView: UIView = UIView(frame: StringHelper().CGRectMake(0.0, 0.0, UIScreen.main.bounds.width, 20.0))
        statusBarView.backgroundColor = UIColor(colorLiteralRed: 9.0/255.0, green: 52.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        
        view.addSubview(statusBarView)
        
        
        subCategoriesTableView.estimatedRowHeight = 44; // put max you expect here.
        
        subCategoriesTableView.rowHeight = UITableViewAutomaticDimension;
        
        
        subCategoryBannerImageView.image = UIImage(named: category["sub_category_image"].stringValue)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
         return category["sub_category"][0]["popular"].count
        }
        else if section == 1{
         return category["sub_category"][1]["others"].count
        }
        else{
         return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        if category["sub_category"][1]["others"] == []{
          return 1
        }
        else {
         return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if (indexPath as NSIndexPath).section == 0{
         let cellIdentifier = "popularSubCategoriesCell"
         let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoriesTableViewCell
            cell.subCategoryNameLabel.text = category["sub_category"][0]["popular"][(indexPath as NSIndexPath).row]["sub_category_name"].stringValue
            return cell
        }
        else{
          
            let cellIdentifier = "popularSubCategoriesCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoriesTableViewCell
           cell.subCategoryNameLabel.text = category["sub_category"][1]["others"][(indexPath as NSIndexPath).row]["sub_category_name"].stringValue
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName:String?
        switch (section)
        {
      
        case 0:
            sectionName = "Popular";
            break;
        case 1:
            sectionName = "Others";
            break;
        default:
            sectionName = "Popular";
            break;
        }
        return sectionName;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if category["sub_category"][1]["others"] == []{
         return 0
        }
        else {
        return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if StringHelper.isInternetAvailable(){
        
          if (indexPath as NSIndexPath).section == 0{
          
            if indexPath.row == 0{
             isSeguedForViewAllAds = true
            
            }
            
            self.subCategoryId = category["sub_category"][0]["popular"][(indexPath as NSIndexPath).row]["sub_category_id"].intValue
            self.subCategoryName = category["sub_category"][0]["popular"][(indexPath as NSIndexPath).row]["sub_category_name"].stringValue
            self.image = category["sub_category"][0]["popular"][(indexPath as NSIndexPath).row]["image"].stringValue
            performSegue(withIdentifier: "subCategoryDetailSegue", sender: self)
        }
        else{
            self.subCategoryId = category["sub_category"][1]["others"][(indexPath as NSIndexPath).row]["sub_category_id"].intValue
            self.subCategoryName = category["sub_category"][1]["others"][(indexPath as NSIndexPath).row]["sub_category_name"].stringValue
             self.image = category["sub_category"][1]["others"][(indexPath as NSIndexPath).row]["image"].stringValue
            performSegue(withIdentifier: "subCategoryDetailSegue", sender: self)
        }
        }else{
         StringHelper.showAlert()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "Futura", size: 18)!
        title.textColor = UIColor(colorLiteralRed: 200.0/255.0, green: 58.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font=title.font
        header.textLabel?.textColor=title.textColor
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subCategoryDetailSegue"{
            let destinationVc = segue.destination as! SubCategoryDetailViewController
            
            SubCategoryDetailViewController.categoryName = self.category["category_name"].stringValue
            destinationVc.subCategoryId = self.subCategoryId
            destinationVc.subCategoryName = self.subCategoryName
            SubCategoryDetailViewController.image = self.image
            destinationVc.isSeguedForViewAllAds = self.isSeguedForViewAllAds
            
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
