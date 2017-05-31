//
//  SecondViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 22/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit



class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{

    @IBOutlet var tableView: UITableView!
    var searchController: UISearchController!
    var filterJSON : JSON = []
    var jsonSearchDataArray: JSON = []
    var jsonFromSearchController :JSON = []
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

            configureSearchController()
            self.searchController.searchResultsUpdater = self
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.tableFooterView = UIView()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonSearchDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "autoSearchCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AutoSerarchTableViewCell
       
        cell.resultLabel.text = StringHelper.convertHtmlToString(jsonSearchDataArray[(indexPath as NSIndexPath).row]["label"].stringValue)
        
        return cell
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
       self.searchController.isActive = false
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if StringHelper.isInternetAvailable(){
            self.jsonFromSearchController = jsonSearchDataArray[(indexPath as NSIndexPath).row]
            
            self.performSegue(withIdentifier: "SearchSegue", sender: self)
        }else{
          StringHelper.showAlert()
        }
       
    }
    
    
    func fetchDataForAutoSearch(_ searchBarString : String) {
        if !searchBarString.isEmpty{
        AppService.fetchDataFromUrl(AppService.autoSearchUrl + searchBarString){
        (JSON) -> () in
            self.jsonSearchDataArray = JSON["auto_search"]
            self.tableView.reloadData()
        }
    }
}
    
    func configureSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Zamroo"
       
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        //To Handle nils
        var searchBarText = searchController.searchBar.text
        if (searchBarText == nil) {
            searchBarText = ""
        }
       searchBarText = searchBarText?.components(separatedBy: " ").joined(separator: "").lowercased()
        if StringHelper.isInternetAvailable(){
           fetchDataForAutoSearch(searchBarText!)
        }else{
          StringHelper.showAlert()
        }
       
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue"{
         let destinationVc = segue.destination as! SearchResultFilterViewController
           destinationVc.jsonFromSearchController = self.jsonFromSearchController
        }
    }
}

