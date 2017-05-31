//
//  CategoryViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 01/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class CategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var categoryArray:JSON = []
    var subCategoryJSON : JSON = []
    var isReachedFromFilterVc = false
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        getCategoryList()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryTableViewCell
        cell.categoryIcon.image = UIImage(named: categoryArray[(indexPath as NSIndexPath).row]["image"].stringValue)
        cell.categoryNameLabel.text = categoryArray[(indexPath as NSIndexPath).row]["category_name"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.subCategoryJSON = categoryArray[(indexPath as NSIndexPath).row]["sub_category"]
        performSegue(withIdentifier: "CategoryToSubCategorySegue", sender: self)
    }
    
    func getCategoryList(){
        
       self.categoryArray = AppService.fetchCategoryList2()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryToSubCategorySegue"{
          let destinationVc = segue.destination as! ListSubCategoryViewController
            destinationVc.subCategoryJSON = self.subCategoryJSON
            destinationVc.isReachedFromFilterVc = self.isReachedFromFilterVc
        }
    }

}
