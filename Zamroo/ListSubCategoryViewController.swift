//
//  ListSubCategoryViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 11/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class ListSubCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    
    var subCategoryJSON : JSON = []
    
    var subCategory: JSON = []
    var isReachedFromFilterVc = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategoryJSON.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SubCategoryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoryTableViewCell
        cell.subCategoryTitle.text = subCategoryJSON[(indexPath as NSIndexPath).row]["sub_category_name"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.subCategory = subCategoryJSON[(indexPath as NSIndexPath).row]
        
        if isReachedFromFilterVc{
           performSegue(withIdentifier: "SubCategoryToFilterSegue", sender: self)
        }
        
        else{
           performSegue(withIdentifier: "SubCategoryToPostAdSegue", sender: self)
        }
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SubCategoryToFilterSegue"{
        let destinationVc = segue.destination as! FilterViewController
            
           destinationVc.subCategoryJson = self.subCategory
           destinationVc.isSubCategoryDataSet = true
            
        }
        else if segue.identifier == "SubCategoryToPostAdSegue"{
        
            let destinationVc = segue.destination as! PostAdViewController
            
            destinationVc.subCategory = self.subCategory
            destinationVc.isReachedFromSubCategorySegue = true
            
        }
        
    }

}
