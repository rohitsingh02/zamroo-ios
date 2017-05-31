//
//  SearchResultFilterViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 10/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

import Kingfisher

class SearchResultFilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    var jsonFromSearchController :JSON = []
    
    var messageFrame = UIView()
    var activityIndicator1:UIActivityIndicatorView?
    
    var dataJson :[JSON] = []
    var productId = 0
    var productCategory = ""
    var productJson :JSON = []
    var isSegueFromHomeVc = false
    var isApiCalled = false
//    var isSendForSeeAllAd = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        progressBarDisplayer(indicator: true)
        if isSegueFromHomeVc{
          let url = AppService.viewAllAdsUrl + "\(100)" + "?withphoto=yes"
          fetchViewAllAdsData(url)
        }
        else{
        fetchDataForSearchDetailView(jsonFromSearchController["id"].stringValue.replacingOccurrences(of: "\\", with: "")  + "?withphoto=yes")
        self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataJson.count == 0 && isApiCalled{
            return 1
        }
        else{
            return dataJson.count
        }
     }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataJson.count == 0 && isApiCalled{
            
            let cellIdentifier = "NoAdsCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoryDetailTableViewCell
            
            return cell
        }
        else{
        let CellIdentifier = "searchResultFilterCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! SubCategoryDetailTableViewCell
        
            
            
        let URL = Foundation.URL(string:AppService.getImageUrl(StringHelper.convertStringForImageUrl(dataJson[(indexPath as NSIndexPath).row]["category_name"].stringValue), subCategory: StringHelper.convertStringForImageUrl(dataJson[(indexPath as NSIndexPath).row]["sub_cat_name"].stringValue), size: "small", imageCode: dataJson[(indexPath as NSIndexPath).row]["image"].stringValue))
        cell.adImage.kf_setImage(with: URL, placeholder: UIImage(named: "chache_image"), options: [.transition(.fade(1))], progressBlock: { (receivedSize, totalSize) -> () in
            print("Download Progress: \(receivedSize)/\(totalSize)")}, completionHandler: { (image, error, cacheType, imageURL) -> () in
                print("Downloaded and set!")
        })
        cell.adTitle.text = dataJson[(indexPath as NSIndexPath).row]["product_name"].stringValue
        cell.priceLabel.text = "\u{20B9}" + dataJson[(indexPath as NSIndexPath).row]["price"].stringValue
//            cell.locationIconImageView.image = UIImage(named: "location_icon")
        cell.adLocation.text = dataJson[(indexPath as NSIndexPath).row]["city"].stringValue
        cell.timeDurationLabel.text = dataJson[(indexPath as NSIndexPath).row]["date_modified"].stringValue
            
        cell.timeDurationLabel.text = StringHelper.timeAgoSinceDate(date: StringHelper.convertStringToNSDate(date: dataJson[(indexPath as NSIndexPath).row]["date_modified"].stringValue), numericDates: true)

        return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if StringHelper.isInternetAvailable(){
            self.productId = dataJson[(indexPath as NSIndexPath).row]["product_id"].intValue
            self.productCategory = dataJson[(indexPath as NSIndexPath).row]["category_name"].stringValue
            self.productJson = dataJson[(indexPath as NSIndexPath).row]
            performSegue(withIdentifier: "SearchFilterToProductDetailSegue", sender: self)
        }else{
         StringHelper.showAlert()
        }
    }

    @IBAction func sortButton(_ sender: AnyObject) {
    }
    
    
    @IBAction func filterButton(_ sender: AnyObject) {
    }
    
    func fetchDataForSearchDetailView(_ urlString : String) {
        AppService.fetchDataFromUrl(urlString){
            (JSON) -> () in
            print(JSON)
            self.dataJson = JSON["search_result"].arrayValue
            self.isApiCalled = true
            self.tableView.reloadData()
           
            self.activityIndicator1?.stopAnimating()
            self.messageFrame.removeFromSuperview()
            
        }
    }
    
    func fetchViewAllAdsData(_ urlString : String) {
        AppService.fetchDataFromUrl(urlString){
            (JSON) -> () in
            
            self.dataJson = JSON["listing"].arrayValue
            self.isApiCalled = true
            self.tableView.reloadData()
            
            self.activityIndicator1?.stopAnimating()
            self.messageFrame.removeFromSuperview()
            
        }
    }
  
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchFilterToProductDetailSegue"{
         let destinationVc = segue.destination as! ProductDetailViewController
            destinationVc.productId = self.productId
            destinationVc.productCategory = self.productCategory
            destinationVc.productJSON = self.productJson
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataJson.count == 0 && isApiCalled{
            return 300
        }
        else{
            return 125
            
        }
    }
    
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
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
    
    
}
