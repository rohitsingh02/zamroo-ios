//
//  FilterViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 09/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


class FilterViewController: UIViewController,UITextFieldDelegate {

    

    @IBOutlet var imageSwitch: UISwitch!
    
    @IBOutlet var minPriceTf: UITextField!
    
    
    @IBOutlet var maxPriceTf: UITextField!
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var categoryView: DesignableView!
    
    @IBOutlet var locationView: DesignableView!
    
    @IBOutlet var selectCategoryLabel: UILabel!
    
    var subCategoryId = 0
    var previousSubCategoryId = 0
    var subCategoryJson : JSON = []
    var isSubCategoryDataSet = false
    var urlString = ""
    static var previousSubCategoryName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarView: UIView = UIView(frame: StringHelper().CGRectMake(0.0, 0.0, UIScreen.main.bounds.width, 20.0))
        statusBarView.backgroundColor = UIColor(colorLiteralRed: 9.0/255.0, green: 52.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        
        view.addSubview(statusBarView)
        
        let myLocationViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(FilterViewController.myLocationViewTapped))
        locationView.addGestureRecognizer(myLocationViewTapGesture)
        locationLabel.text = LocalStore.getCityName()
        selectCategoryLabel.text = FilterViewController.previousSubCategoryName
        
       minPriceTf.delegate = self
       maxPriceTf.delegate = self
        
        let myCategoryViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(FilterViewController.myCategoryViewTapped))
        categoryView.addGestureRecognizer(myCategoryViewTapGesture)
        
        if isSubCategoryDataSet{
            
            FilterViewController.previousSubCategoryName = subCategoryJson["sub_category_name"].stringValue
            selectCategoryLabel.text = subCategoryJson["sub_category_name"].stringValue
            subCategoryId = subCategoryJson["sub_category_id"].intValue
        }
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    
    func myLocationViewTapped(){
        performSegue(withIdentifier: "FilterVcToSelectLocationSegue", sender: self)
    }
   
    func myCategoryViewTapped(){
        performSegue(withIdentifier: "FilterToCategorySegue", sender: self)
    }
    
    @IBAction func searchButton(_ sender: AnyObject) {
        urlString = AppService.adUrl
        if isSubCategoryDataSet {
            urlString = urlString + "\(subCategoryId)"
        }
        else if !isSubCategoryDataSet{
            urlString = urlString + "\(previousSubCategoryId)"
        }
        let cityId = LocalStore.getCityId()!
         urlString = urlString + "/" + "\(cityId)"
        
        
        if !(minPriceTf.text?.isEmpty)! && !(maxPriceTf.text?.isEmpty)!{
          
            urlString = urlString + "?price_filter=\(minPriceTf.text!)" + "-" + "\(maxPriceTf.text!)"
        }
       // self.navigationController!.viewControllers.remove(at: 1)
      performSegue(withIdentifier: "FilterToSubCategoryDetailSegue", sender: self)
        
    }

    @IBAction func backButton(_ sender: AnyObject) {
        
        if(self.navigationController == nil){
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.pop(animated: true)
        }
        
    }
    
    @IBAction func resetButton(_ sender: AnyObject) {
        
        self.selectCategoryLabel.text = "View All Ads"
        self.maxPriceTf.text = ""
        self.minPriceTf.text = ""
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterVcToSelectLocationSegue"{
        let destinationVc = segue.destination as! SelectLocationViewController
          destinationVc.isCalledFromFilterView = true
        }
        
        else if segue.identifier == "FilterToSubCategoryDetailSegue"{
            
//            let destinationNavigationController = segue.destination as! UINavigationController
            let targetController = segue.destination as! SubCategoryDetailViewController
            
            
            
//            let destinationVc = segue.destination as! SubCategoryDetailViewController
            targetController.urlString = self.urlString
            //targetController.isApiCalled = true
            targetController.isFilterSearchEnable = true

        }
        else if segue.identifier == "FilterToCategorySegue"{
            let destinationVc = segue.destination as! CategoryViewController
            destinationVc.isReachedFromFilterVc = true
           
        }
        
    }
    
    
}
