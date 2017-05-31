//
//  SelectCityFromStateViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 01/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class SelectCityFromStateViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var citiesArray:JSON = []
    var state:State?
    var isCalledFromFilterView = false
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        getCityNameFromStateId(state!)
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
     LocalStore.saveCityName(citiesArray[(indexPath as NSIndexPath).row]["city"].stringValue)
     LocalStore.saveCityId(citiesArray[(indexPath as NSIndexPath).row]["city_id"].intValue)
        if isCalledFromFilterView{
              performSegue(withIdentifier: "CityToFilterSegue", sender: self)
        }
        else{
              performSegue(withIdentifier: "HomeSegue", sender: self)
        }
   
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CitiesCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TopCitiesListTableViewCell
        cell.topCityTitleLabel.text = citiesArray[(indexPath as NSIndexPath).row]["city"].stringValue
        cell.topCitySubtitleLabel.text = state?.state
        return cell
    }
    
    func getCityNameFromStateId(_ state:State) {
        AppService.fetchDataFromUrl(AppService.cityUrl + "\(state.stateId)"){
            (JSON) -> () in
            
            self.citiesArray = JSON["city"]
            self.tableView.reloadData()
            
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
