//
//  ViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 29/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SCLAlertView
import HELargeCenterTabBarController



class HomeViewController:  UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

//36
    @IBOutlet var wholeContentView: UIView!
    
    
    @IBOutlet var adInSpotlightLabel: UILabel!
    
    fileprivate var categoryArray :JSON = []
    
    fileprivate var featureAdsArray:JSON = []
    
    fileprivate var productsByCategoryArray:JSON = []
    
    fileprivate var productByCategoryDictionary:JSON = [:]
    
    fileprivate var productJSON:JSON = [:]
    fileprivate var currentRow = 0;
    
    fileprivate var productId = 0;
    
    @IBOutlet var featureAdView: UIView!
    
    @IBOutlet var pageMenuView: UIView!
    
    var isViewsHidden = false
    
    static var count = 1
    
    var messageFrame = UIView()
    var activityIndicator:UIActivityIndicatorView?
    
    var featureProduct : FeatureProduct?
    
    var showStatusBar = true
    
    fileprivate var category:JSON = [:]
    
    var productCategory = ""
    
    
    @IBOutlet var cityNameButton: UIButton!
    
    @IBOutlet var contentViewHeightMultiplierConstraint: NSLayoutConstraint!
    @IBOutlet var viewMoreButtonTopConstraint: NSLayoutConstraint!
    
    @IBOutlet var viewMoreButtonHeight: NSLayoutConstraint!
    
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet var viewMore: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var featuredAdsCollectionView: UICollectionView!
    
    @IBOutlet var PageMenuTitleCollectionView: UICollectionView!
    
    @IBOutlet var pageMenuContentCollectionView: UICollectionView!
    
    let cellIdentifier = "Cell"
    let featuredAdsCellIdentifier = "FeaturedAdsCell"
    let pageMenuTitleCvCellIdentifier = "PageMenuTitleCell"
    let pageMenuContentCvCellIdentifier = "PageMenuContentCell"
    var width:CGFloat?
    var height:CGFloat?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showStatusBar(false)
        
        
       if let tabBarController = self.tabBarController as? HELargeCenterTabBarController {
        
        
                if let unselectedImage = UIImage(named: "postadicon1"), let selectedImage = UIImage(named: "postadicon1") {
                    tabBarController.addCenterButton(unselectedImage, selectedImage: selectedImage)
                    
                }

       }

        if LocalStore.getCityName() != nil {
           cityNameButton.setTitle(LocalStore.getCityName()  , for: UIControlState())
        }else{
         cityNameButton.setTitle("Bangalore"  , for: UIControlState())
         LocalStore.saveCityName("Bangalore")
         LocalStore.saveCityId(441)
         LocalStore.saveStateId(17)
        }
       
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.featuredAdsCollectionView.delegate = self
        self.featuredAdsCollectionView.dataSource = self
        
        self.PageMenuTitleCollectionView.delegate = self
        self.PageMenuTitleCollectionView.dataSource = self
        
        self.pageMenuContentCollectionView.delegate = self
        self.pageMenuContentCollectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        categoryArray = AppService.fetchCategoryList()
        
    }


    override var prefersStatusBarHidden : Bool {
        if showStatusBar {
            return false
        }
        return true
    }
    
    fileprivate func showStatusBar(_ enabled: Bool) {
        showStatusBar = enabled
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView == self.collectionView{
        return categoryArray.count + 1
        }
        else if(collectionView == self.featuredAdsCollectionView){
        return featureAdsArray.count
        }
        else if(collectionView == PageMenuTitleCollectionView){
            return AppService.getPageMenuTitleArray().count
        }
        else{
        return productsByCategoryArray.count
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if StringHelper.isInternetAvailable(){
            getFeatureProducts()
            getProductsByCategory()
            wholeContentView.isUserInteractionEnabled = false
            progressBarDisplayer(indicator: true)
           
            
        }else{
            showAlert()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.featuredAdsCollectionView{
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuredAdsCellIdentifier, for: indexPath) as! FeaturedAdsCollectionViewCell
            
            let URL = Foundation.URL(string:AppService.getImageUrl(StringHelper.convertStringForImageUrl(featureAdsArray[(indexPath as NSIndexPath).row]["category_name"].stringValue), subCategory: StringHelper.convertStringForImageUrl(featureAdsArray[(indexPath as NSIndexPath).row]["sub_cat_name"].stringValue), size: "small", imageCode: featureAdsArray[(indexPath as NSIndexPath).row]["image"].stringValue))
           
            cell.featureAdImageView.kf_setImage(with: URL, placeholder: UIImage(named: "chache_image"), options: [.transition(.fade(1))], progressBlock: { (receivedSize, totalSize) -> () in
                                print("Download Progress: \(receivedSize)/\(totalSize)")}, completionHandler: { (image, error, cacheType, imageURL) -> () in
                
            })
            cell.featureAdTitleLabel.text = featureAdsArray[(indexPath as NSIndexPath).row]["product_name"].stringValue
            cell.featureAdPriceLabel.text = "\u{20B9}" + featureAdsArray[(indexPath as NSIndexPath).row]["price"].stringValue
            return cell
        }else if(collectionView == self.collectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
            if (indexPath as NSIndexPath).row != 20{
            cell.categoryImageView.image = UIImage(named: categoryArray[(indexPath as NSIndexPath).row]["image"].stringValue)
            cell.categoryLabel.text = "\(categoryArray[(indexPath as NSIndexPath).row]["category_name"])"
            }
            else{
                cell.categoryImageView.image = UIImage(named: "view_more")
                cell.categoryLabel.text = "View All Ads"
            }
              return cell
        }
        else if(collectionView == self.PageMenuTitleCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageMenuTitleCvCellIdentifier, for: indexPath) as! PageMenuTitleCollectionViewCell
            cell.titleLabel.text = "\(AppService.getPageMenuTitleArray()[(indexPath as NSIndexPath).row])"
            cell.titleBarView.tag = (indexPath as NSIndexPath).row
            if (indexPath as NSIndexPath).row == currentRow {
               cell.titleBarView.isHidden = false
            }
            else{
              cell.titleBarView.isHidden = true
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageMenuContentCvCellIdentifier, for: indexPath) as! FeaturedAdsCollectionViewCell
            if(productsByCategoryArray == []){
                cell.featureAdImageView.image  = UIImage(named: "zamroo_default")
            }
            let URL = Foundation.URL(string:AppService.getImageUrl(StringHelper.convertStringForImageUrl(LocalStore.getCurrentCategory()), subCategory: StringHelper.convertStringForImageUrl(productsByCategoryArray[(indexPath as NSIndexPath).row]["sub_cat_name"].stringValue), size: "small", imageCode: productsByCategoryArray[(indexPath as NSIndexPath).row]["image"].stringValue))
            
         
            
            cell.featureAdImageView.kf_setImage(with: URL, placeholder: UIImage(named: "chache_image"), options: [.transition(.fade(1))], progressBlock: { (receivedSize, totalSize) -> () in
                print("Download Progress: \(receivedSize)/\(totalSize)")}, completionHandler: { (image, error, cacheType, imageURL) -> () in
                    print("Downloaded and set!")
            })
            cell.featureAdTitleLabel.text = productsByCategoryArray[(indexPath as NSIndexPath).row]["product_name"].stringValue
            cell.featureAdPriceLabel.text = "\u{20B9}" + productsByCategoryArray[(indexPath as NSIndexPath).row]["price"].stringValue
            return cell
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize(width: (collectionView.bounds.width/3)-0.5, height: (collectionView.bounds.width/3) - 0.58
                
            );
        }
        else if(collectionView == featuredAdsCollectionView || collectionView == pageMenuContentCollectionView){
           return CGSize(width: (collectionView.bounds.width/3 + 27) , height: (collectionView.bounds.width/3 + 55));
        }
        else{
            
            let size = AppService.getPageMenuTitleArray()[indexPath.item].size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)])
            print( "\(size.width + size.height)")
            return CGSize(width:size.width + 12, height: 50)
        //return CGSize(width:(collectionView.bounds.width/2), height: 50);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.PageMenuTitleCollectionView{
           self.currentRow = (indexPath as NSIndexPath).row
           getProductsArrayDataFromDictionary(AppService.getPageMenuTitleArray()[(indexPath as NSIndexPath).row])
           collectionView.reloadData()
        }
        else if collectionView == self.featuredAdsCollectionView{
          
            self.productJSON = featureAdsArray[(indexPath as NSIndexPath).row]
            self.productCategory = featureAdsArray[(indexPath as NSIndexPath).row]["category_name"].stringValue
            
            self.productId = featureAdsArray[(indexPath as NSIndexPath).row]["product_id"].intValue
           
            
            performSegue(withIdentifier: "productDetail", sender: self)
        }
        else if collectionView == self.collectionView{
          
            if (indexPath as NSIndexPath).row == 20{
              
                performSegue(withIdentifier: "SearchAndViewAllAdsSegue", sender: self)
                
            }
            else{
                self.category = categoryArray[(indexPath as NSIndexPath).row]
                performSegue(withIdentifier: "categorySegue", sender: self)
            }
         
        }
        else if collectionView == pageMenuContentCollectionView{
        
            self.productJSON = productsByCategoryArray[(indexPath as NSIndexPath).row]
            self.productCategory = LocalStore.getCurrentCategory()
            self.productId = productsByCategoryArray[(indexPath as NSIndexPath).row]["product_id"].intValue
            
            performSegue(withIdentifier: "productDetail", sender: self)
        
        }
    }
    
    
    @IBAction func viewMoreTapped(_ sender: AnyObject) {
        viewMoreButtonTopConstraint.constant = 0
        viewMoreButtonHeight.constant = 0
        viewMore.isHidden = true
        contentViewHeightMultiplierConstraint.constant = 355
        heightConstraint.constant = self.collectionView.contentSize.height
        if isViewsHidden{
         contentViewHeightMultiplierConstraint.constant = contentViewHeightMultiplierConstraint.constant - 36 - self.featureAdView.frame.height - pageMenuView.frame.height
        }
        
    }
    
    func getFeatureProducts() {
        AppService.fetchDataFromUrl(AppService.featureProductUrl){
        (JSON) -> () in
           self.featureAdsArray = JSON["feature_product"]
           self.featuredAdsCollectionView.reloadData()
            self.activityIndicator?.stopAnimating()
            self.messageFrame.removeFromSuperview()
            self.wholeContentView.isUserInteractionEnabled = true
        }
    }
    
    func getProductsByCategory() {
        AppService.fetchDataFromUrl(AppService.latestProductUrl){
        (JSON) -> () in
            self.productByCategoryDictionary = JSON["latest_product_by_Cat"]
            self.getProductsArrayDataFromDictionary("Mobiles & Tablets")
            LocalStore.saveCurrentCategory("Mobiles & Tablets")
        }
    }
    
    func getProductsArrayDataFromDictionary(_ categoryString:String){
       LocalStore.saveCurrentCategory(categoryString)
       self.productsByCategoryArray = self.productByCategoryDictionary[categoryString]
       self.pageMenuContentCollectionView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetail"{
        let destinationVc = segue.destination as! ProductDetailViewController
            destinationVc.productId = self.productId
            destinationVc.productJSON = self.productJSON
            destinationVc.productCategory = self.productCategory
           print(self.productId)
        }
        else if segue.identifier == "categorySegue"{
            let destinationVc = segue.destination as! UINavigationController
            let targetController = destinationVc.topViewController as! SubCategoriesViewController
            
//            let destinationVc = segue.destination as! SubCategoriesViewController
            targetController.category = self.category
        }
        else if segue.identifier == "SearchAndViewAllAdsSegue"{
            let destinationVc = segue.destination as! SearchResultFilterViewController
               destinationVc.isSegueFromHomeVc = true        
        }
        else if segue.identifier == "homeToSearchFilterSegue"{
            let destinationVc = segue.destination as! SearchResultFilterViewController
            destinationVc.isSegueFromHomeVc = true
        }
        
   }
    

    
    @IBAction func seeAllButtonTapped(_ sender: AnyObject) {
        
       // getSeeAllFeatureProducts()
        
        performSegue(withIdentifier: "homeToSearchFilterSegue", sender: self)
        
        
        
    }
    
//    func getSeeAllFeatureProducts() {
//        AppService.fetchDataFromUrl(AppService.viewAllAdsUrl + "\(100)"){
//            (JSON) -> () in
//            self.featureAdsArray = JSON["listing"]
//            self.featuredAdsCollectionView.reloadData()
//            
//        }
//    }
    
    func progressBarDisplayer(indicator:Bool ) {
      
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY - 50 , width: 100, height: 100))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.6)
        if indicator {
//            activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 25, y: 25, width: 50, height: 50), type: NVActivityIndicatorType(rawValue: NVActivityIndicatorType.ballClipRotateMultiple.rawValue), color:  UIColor(red: CGFloat(237 / 255.0), green: CGFloat(85 / 255.0), blue: CGFloat(101 / 255.0), alpha: 1), padding: CGFloat(0))
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
            activityIndicator?.activityIndicatorViewStyle =  UIActivityIndicatorViewStyle.whiteLarge
            
            activityIndicator?.startAnimating()
            messageFrame.addSubview(activityIndicator!)
            
        }
        view.addSubview(messageFrame)
    }
    
    
    func showAlert(){
    
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("OK") {
           
            if HomeViewController.count == 1{
                
                self.adInSpotlightLabel.isHidden = true
                
                self.featureAdView.removeFromSuperview()
                self.pageMenuView.removeFromSuperview()
                self.contentViewHeightMultiplierConstraint.constant =
                    self.contentViewHeightMultiplierConstraint.constant - 35 - self.featureAdView.frame.height - self.pageMenuView.frame.height
                self.isViewsHidden = true
               HomeViewController.count = HomeViewController.count + 1
            }
           
            
            
        }
        alertView.showError("Connection Error !", subTitle: "No Internet Connection")
     
    }
    
    
    
    
    
    
}

