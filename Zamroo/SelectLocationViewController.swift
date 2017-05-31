//
//  SelectLocationViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 31/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import Alamofire


class SelectLocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let sectionTitleArray = ["Top Cities","States"]
    let cellIdentifier1 = "StateCell"
    let cellIdentifier2 = "TopCityCell"
    var topCitiesArray:JSON = []
    var statesArray:JSON = []
    var state:State!
    var isCalledFromFilterView = false
   
    
    @IBOutlet var searchEditText: DesignableTextField!
    
    @IBOutlet var selectLocationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.selectLocationTableView.dataSource = self
        self.selectLocationTableView.delegate = self
        self.selectLocationTableView.tableFooterView = UIView()
        getTopCities()
        getStates()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
          return 1
        }
        else if(section == 1){
         return topCitiesArray.count
        }
        else{
            return statesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1, for: indexPath) as! StatesListTableViewCell
            cell.stateTitleLabel.text = "All Cities"
            return cell
        }
            
        else if (indexPath as NSIndexPath).section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as! TopCitiesListTableViewCell
            cell.topCityTitleLabel.text = topCitiesArray[(indexPath as NSIndexPath).row]["city_name"].stringValue
            cell.topCitySubtitleLabel.text =  topCitiesArray[(indexPath as NSIndexPath).row]["state_name"].stringValue
            return cell
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1, for: indexPath) as! StatesListTableViewCell
            cell.stateTitleLabel.text = statesArray[(indexPath as NSIndexPath).row]["state"].stringValue
            return cell
        }
        
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName:String?
        switch (section)
        {
        case 0:
            break;
        case 1:
            sectionName = "Top Cities";
            break;
        case 2:
            sectionName = "States";
            break;
        default:
            sectionName = "States";
            break;
        }
        return sectionName;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section)
        {
        case 0:
            return 0
        case 1:
            return 50
        case 2:
            return 50
        default:
            return 0
        }
    }
    
    func getTopCities(){
        self.topCitiesArray = AppService.fetchTopCity()
    }
    
    func getStates(){
            self.statesArray = AppService.fetchStates()
        
    }
    
    @IBAction func backButtonDidTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as NSIndexPath).section == 0{
            
            LocalStore.saveCityName("All Cities")
            LocalStore.saveCityId(0)
            
            if isCalledFromFilterView{
               performSegue(withIdentifier: "TopCityToFilterSegue", sender: self)
            }
            else{
                performSegue(withIdentifier: "TopCityToHomeSegue", sender: self)
            }
  
        }
        
        if (indexPath as NSIndexPath).section == 1{
            
          LocalStore.saveCityName(topCitiesArray[(indexPath as NSIndexPath).row]["city_name"].stringValue)
            
          LocalStore.saveCityId(topCitiesArray[(indexPath as NSIndexPath).row]["city_id"].intValue)
          LocalStore.saveStateId(topCitiesArray[(indexPath as NSIndexPath).row]["state_id"].intValue)

            if isCalledFromFilterView{
                performSegue(withIdentifier: "TopCityToFilterSegue", sender: self)
            }
            else{
                performSegue(withIdentifier: "TopCityToHomeSegue", sender: self)
            }
        }
        
        if (indexPath as NSIndexPath).section == 2 {
            
           self.state  = DataHelper.getStateObject(statesArray[(indexPath as NSIndexPath).row])
           LocalStore.saveStateId(Int(state.stateId)!)
           performSegue(withIdentifier: "selectCityFromState", sender: self)
        }
       
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
    
        if segue.identifier == "selectCityFromState"{
            let destinationVC = segue.destination as! SelectCityFromStateViewController
            destinationVC.state = self.state
            destinationVC.isCalledFromFilterView = self.isCalledFromFilterView
            
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
    


