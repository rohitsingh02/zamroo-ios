//
//  SubCategoryDetailViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 07/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

import Kingfisher

class SubCategoryDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FilterViewDelegate{

    @IBOutlet var subCategoryHeaderLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var subCategoryLabel: UILabel!
    
    @IBOutlet var subCategoryImageBanner: UIImageView!
    var messageFrame = UIView()
    var activityIndicator1:UIActivityIndicatorView?
    
    
    var subCategoryId : Int = 0
    var subCategoryName = ""
    static var categoryName = ""
    static var image = ""
    var listingJson : [JSON] = []
    var productId = 0
    var productJSON : JSON = []
    var productCategory = ""
    var withImage = false
    var offset = 10
    var isLoading = false
    var isFilterSearchEnable = false
    var urlString = ""
    
    var activityIndicator:UIActivityIndicatorView?
    var isApiCalled = false
    var isSeguedForViewAllAds = false
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        let statusBarView: UIView = UIView(frame: StringHelper().CGRectMake(0.0, 0.0, UIScreen.main.bounds.width, 20.0))
        statusBarView.backgroundColor = UIColor(colorLiteralRed: 9.0/255.0, green: 52.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        
        view.addSubview(statusBarView)
        progressBarDisplayer(indicator: true)
        
        subCategoryHeaderLabel.text = SubCategoryDetailViewController.categoryName
        let view1 = StringHelper().CGRectMake(0, 0, self.view.frame.width, 50)
        let a = UIView(frame: view1)
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        a.addSubview(activityIndicator!)
        activityIndicator?.center = a.center
        self.activityIndicator?.isHidden = true
        tableView.tableFooterView = a
    
         tableView.register(UINib(nibName: "FilterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FilterView")

        if isSeguedForViewAllAds{
          let url = AppService.viewAllAdsUrl + "\(subCategoryId)"
          fetchDataForSubCategoryViewAllAds(url)
        
        }
        else{
            if !isFilterSearchEnable{
                
                fetchDataFromSubCategoryId()
            }
            else{
                print(urlString)
                fetchDataIfSearchFilterEnable(urlString)
            }
            
        }
       
        
        subCategoryLabel.text = self.subCategoryName
        subCategoryImageBanner.image = UIImage(named: SubCategoryDetailViewController.image)


    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if listingJson.count == 0 && isApiCalled{
         return 1
        }
        else{
         return listingJson.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if listingJson.count == 0 && isApiCalled{
        
        let cellIdentifier = "NoAdsCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoryDetailTableViewCell
        
            return cell
        }
        else{
            let cellIdentifier = "subCategoryDetailListCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoryDetailTableViewCell
            
            let URL = Foundation.URL(string:AppService.getImageUrl(StringHelper.convertStringForImageUrl(listingJson[(indexPath as NSIndexPath).row]["category_name"].stringValue), subCategory: StringHelper.convertStringForImageUrl(listingJson[(indexPath as NSIndexPath).row]["sub_cat_name"].stringValue), size: "medium", imageCode: listingJson[(indexPath as NSIndexPath).row]["image"].stringValue))
            cell.adImage.kf_setImage(with: URL, placeholder: UIImage(named: "chache_image"), options: [.transition(.fade(1))], progressBlock: { (receivedSize, totalSize) -> () in
                print("Download Progress: \(receivedSize)/\(totalSize)")}, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    print("Downloaded and set!")
            })
            cell.adTitle.text = listingJson[(indexPath as NSIndexPath).row]["product_name"].stringValue
            cell.priceLabel.text = "\u{20B9}" + listingJson[(indexPath as NSIndexPath).row]["price"].stringValue
            cell.adLocation.text = listingJson[(indexPath as NSIndexPath).row]["city"].stringValue
            
            cell.timeDurationLabel.text = StringHelper.timeAgoSinceDate(date: StringHelper.convertStringToNSDate(date: listingJson[(indexPath as NSIndexPath).row]["date_modified"].stringValue), numericDates: true)
            
            
            return cell
        
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listingJson.count == 0 && isApiCalled{
         return 300
        }
        else{
            return 125

        }
    }
    
    func fetchDataFromSubCategoryId(){
        
        if withImage {
            AppService.fetchDataFromUrl(AppService.adUrl + "\(subCategoryId)"){
                (JSON) -> () in
                self.listingJson = JSON["listing"].arrayValue
                self.isApiCalled = true
                self.tableView.reloadData()
                
                self.activityIndicator1?.stopAnimating()
                self.messageFrame.removeFromSuperview()
                
            }
        }else{
            AppService.fetchDataFromUrl(AppService.adUrl + "\(subCategoryId)"  + "?withphoto=yes"){
                (JSON) -> () in
                self.listingJson = JSON["listing"].arrayValue
                print(self.listingJson.count)
                self.isApiCalled = true
                self.tableView.reloadData()
                
                self.activityIndicator1?.stopAnimating()
                self.messageFrame.removeFromSuperview()
                
            }
        }
        
     
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if StringHelper.isInternetAvailable(){
            self.productId = listingJson[(indexPath as NSIndexPath).row]["product_id"].intValue
            self.productJSON = listingJson[(indexPath as NSIndexPath).row]
            self.productCategory = listingJson[(indexPath as NSIndexPath).row]["category_name"].stringValue
            performSegue(withIdentifier: "SubCategoryToProductDetailSegue", sender: self)
        
        }else{
         StringHelper.showAlert()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isLoading && (indexPath as NSIndexPath).row == listingJson.count - 1{
            activityIndicator?.isHidden = false
            activityIndicator?.startAnimating()
            isLoading = true
            loadNextCells()
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SubCategoryToProductDetailSegue"{
           let destinationVc = segue.destination as! ProductDetailViewController
            destinationVc.productId = self.productId
            destinationVc.productJSON = self.productJSON
            destinationVc.productCategory = self.productCategory
            
        }
        else if segue.identifier == "FilterSegue"{
            let destinationVc = segue.destination as! FilterViewController
            destinationVc.previousSubCategoryId = self.subCategoryId
            FilterViewController.previousSubCategoryName = self.subCategoryName
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         
        let cell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "FilterView")
        let header = cell as! FilterView
        header.delegate = self
        return header
 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    func filterButtonTapped(){
    
        performSegue(withIdentifier: "FilterSegue", sender: self)

    }
    
    
    func sortButtonTapped(){

    }
    
    
    
    func loadNextCells(){
        offset = offset + 10
        AppService.fetchDataFromUrl(AppService.adUrl + "\(subCategoryId)"  + "?offset=\(offset)"){
            (JSON) -> () in
            if JSON["listing"].arrayValue.count == 0{
               
                self.activityIndicator?.stopAnimating()
                self.isLoading = false
            }
            else{
                self.listingJson = self.listingJson + JSON["listing"].arrayValue
                print(self.listingJson)
                self.tableView.reloadData()
                self.activityIndicator?.stopAnimating()
                self.isLoading = false
            }
            
            
        }
    }
    
    func fetchDataIfSearchFilterEnable(_ urlString : String) {

        AppService.fetchDataFromUrl(urlString){
            (JSON) -> () in
            self.listingJson =  JSON["listing"].arrayValue
            self.isApiCalled = true

            self.tableView.reloadData()
            
            self.activityIndicator1?.stopAnimating()
            self.messageFrame.removeFromSuperview()
            
        }
    }
    
    func fetchDataForSubCategoryViewAllAds(_ urlString : String) {
        
        AppService.fetchDataFromUrl(urlString){
            (JSON) -> () in
            self.listingJson =  JSON["listing"].arrayValue
            print(self.listingJson)
            self.isApiCalled = true

            self.tableView.reloadData()
            
            self.activityIndicator1?.stopAnimating()
            self.messageFrame.removeFromSuperview()
            
        }
    }
    
    func progressBarDisplayer(indicator:Bool ) {
        
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY - 50 , width: 100, height: 100))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.6)
        if indicator {
  
            activityIndicator1 = UIActivityIndicatorView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
            activityIndicator1?.activityIndicatorViewStyle =  UIActivityIndicatorViewStyle.whiteLarge
            
            activityIndicator1?.startAnimating()
            messageFrame.addSubview(activityIndicator1!)
            
        }
        view.addSubview(messageFrame)
    }
    
    
    @IBAction func backButttonTapped(_ sender: Any) {
        
        print("mainIconTapped: " + String(describing: self.navigationController)); 
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRoot(animated: true)
        
    }
    
}

extension UINavigationController {
    func pop(animated: Bool) {
        _ = self.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        _ = self.popToRootViewController(animated: animated)
    }
}
