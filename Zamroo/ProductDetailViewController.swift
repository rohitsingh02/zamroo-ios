//
//  ProductDetailViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 02/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import ImageSlideshow
import MessageUI

class ProductDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,ImageNotAvailableDelegate {

    @IBOutlet var containerView: UIView!
    
    var productId = 0
    var productJSON:JSON = []
    var productCategory = ""
    var messageFrame = UIView()
    var activityIndicator:UIActivityIndicatorView?
   
    fileprivate var productDataArray : [JSON] = []
    fileprivate var productAttributesDictionary:[String:JSON] = [String:JSON]()
    var productAttributesImagesArray :JSON = []
    let cellIdentifierSection0 = "productPrice"
    let cellIdentifierSection1 = "productAttribute"
    let cellIdentifierSection2 = "productDescription"
    let cellIdentifierSection3 = "shareListing"
    let cellIdentifierSection4 = "safetyTips"
    var dictKeyArray:[String] = []
    var containerViewController:ImageSlideShowContentViewController?
    
 

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
       
        
        let statusBarView: UIView = UIView(frame: StringHelper().CGRectMake(0.0, 0.0, UIScreen.main.bounds.width, 20.0))
        statusBarView.backgroundColor = UIColor(colorLiteralRed: 9.0/255.0, green: 52.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        view.addSubview(statusBarView)
        progressBarDisplayer(indicator: true)
        self.tableView.isUserInteractionEnabled = true
        
        if StringHelper.isInternetAvailable(){
            getProductUsingProductId(productId)
            getProductAttributesUsingProductId(productId)
        }else{
         StringHelper.showAlert()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
         return productAttributesDictionary.count
        }
        else{
         return 1
        }
    }
    
    
    func ifImageNotAvailable(){
        self.tableView.tableHeaderView = nil
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath as NSIndexPath).section == 0{
          let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSection0, for: indexPath) as! ProductPriceTableViewCell
            if !productDataArray.isEmpty{
                cell.productNAmeLabel.text = productDataArray[0]["product_name"].stringValue
                cell.productPriceLabel.text = "\u{20B9}" + productDataArray[0]["price"].stringValue
                cell.postedLocation.text = productDataArray[0]["city"].stringValue
                cell.postedTimeLabel.text =
                    StringHelper.timeAgoSinceDate(date: StringHelper.convertStringToNSDate(date: productDataArray[0]["date_modified"].stringValue), numericDates: true)
            }
          
          return cell
        }
        else if (indexPath as NSIndexPath).section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSection1, for: indexPath) as! ProductAttributeTableViewCell
            if !productAttributesDictionary.isEmpty{
                
            
            cell.attributeNameLabel.text = dictKeyArray[(indexPath as NSIndexPath).row]
            cell.attributeValueLabel.text = productAttributesDictionary["\(dictKeyArray[(indexPath as NSIndexPath).row])"]?.stringValue
            }
            return cell
        }
        else if (indexPath as NSIndexPath).section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSection2, for: indexPath) as! ProductDescriptionTableViewCell
            if !productDataArray.isEmpty {
                
            cell.productDescriptionValueLabel.text = StringHelper.convertHtmlToString(productDataArray[0]["product_description"].stringValue)
            }
            return cell
        }
        else if (indexPath as NSIndexPath).section == 3{
        
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSection3, for: indexPath) as! ShareListingTableViewCell
            if !productDataArray.isEmpty {
                
                cell.userProfileImage.image = UIImage(named: "profile_pic")
                cell.userNameLabel.text = productDataArray[0]["first_name"].stringValue
                cell.AdIdLabel.text = "Ad Id: \(productId)"
                cell.reportAdButton.setTitle("Report Ad", for: UIControlState())
                
            }
            return cell
        
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifierSection4, for: indexPath) as! SafetyTableViewCell
            
            cell.safetyLabel.text = "Safety Tips :"
            cell.safetyLine1.text = "1. Never transfer payment online, pay in cash only."
            cell.safetyLine2.text = "2. Beware if the goods are cheaper than normal"
            cell.safetyLine3.text = "3. Meet the seller at public place."
            cell.moreButton.setTitle("more...", for: UIControlState())
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName:String?
        switch (section)
        {
        case 0:
            break;
        case 1:
            break;
        case 2:
            sectionName = "Product Description :";
            break;
        default:
            break;
        }
        return sectionName;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch (section)
        {
        case 2:
            return 40
        default:
            return 6
        }
    }
    
    func getProductUsingProductId(_ id:Int){
        AppService.fetchDataFromUrl(AppService.productUrl + "\(id)"){
            (JSON) -> () in
            self.productDataArray = JSON["product_data"].arrayValue
            self.tableView.reloadData()
        }
    }
   
    func getProductAttributesUsingProductId(_ id:Int){
        AppService.fetchDataFromUrl(AppService.productAttributesUrl + "\(id)"){
            (JSON) -> () in
            self.productAttributesDictionary = JSON["product_data_attributes"].dictionaryValue
            self.dictKeyArray = Array(self.productAttributesDictionary.keys)
            self.tableView.reloadData()
            
            self.activityIndicator?.stopAnimating()
            self.messageFrame.removeFromSuperview()
            self.tableView.isUserInteractionEnabled = true
            
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "containerViewSegue" {
            
        
             containerViewController = (segue.destination as? ImageSlideShowContentViewController)!
            containerViewController?.delegate = self
            containerViewController!.productJSON = self.productJSON
            print(productJSON)
            print(productCategory)
            containerViewController!.productCategory = self.productCategory
            
        }
    }
    
 
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func callNowButtonTapped(_ sender: AnyObject) {
        
        showCallAlertAction()
        
    }
    
    @IBAction func smsButtonTapped(_ sender: AnyObject) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = ["\(productDataArray[0]["mobile_no"])"]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func emailButtonTapped(_ sender: AnyObject) {
       
        if MFMailComposeViewController.canSendMail()  {
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            mailComposer.setToRecipients(["\(productDataArray[0]["user_email"])"])
            mailComposer.setSubject("\(productDataArray[0]["product_description"]) + 'at Zamroo'")
            mailComposer.setMessageBody("\(productDataArray[0]["product_description"]) + 'at Zamroo'", isHTML: false)
            

           present(mailComposer, animated: true)
        }
        else{
        //show erroe message
        
        }
    
    }
    fileprivate func showCallAlertAction() {
        let alertController = UIAlertController(title: "\(productDataArray[0]["mobile_no"])", message: nil, preferredStyle: .actionSheet)
        
        let callAction = UIAlertAction(title: "Call", style: .default, handler: { (UIAlertAction)in
            print("Done !!")
            
            
            UIApplication.shared.openURL(NSURL(string:"tel://"+"\(self.productDataArray[0]["mobile_no"])") as! URL)
            
        })
        alertController.addAction(callAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    
}

extension ProductDetailViewController :ShareListingTableViewCellDelegate,SafetyDelegate {

    func facebookShareButton(cell:UITableViewCell,sender: AnyObject){
       
        
        
    
    
    }
    
    
    func  twitterShareButtonTapped(cell:UITableViewCell,sender: AnyObject){
    
        
        
    
    }
    
    
    func googleShareButton(cell:UITableViewCell,sender: AnyObject){
    
        
        
    
    }
    
    
    func whattsShareButton(cell:UITableViewCell,sender: AnyObject){
    
        
    
    
    
    }
    
    func reportAdButton(cell:UITableViewCell,sender: AnyObject){
        

        
    }
    
    func moreButton(cell:UITableViewCell,sender: AnyObject){
        
        
        
    }
    
    
    
    func progressBarDisplayer(indicator:Bool ) {
        
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY - 50 , width: 100, height: 100))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.6)
        if indicator {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 25, y: 25, width: 50, height: 50))
            activityIndicator?.activityIndicatorViewStyle =  UIActivityIndicatorViewStyle.whiteLarge
            
            activityIndicator?.startAnimating()
            messageFrame.addSubview(activityIndicator!)
            
        }
        view.addSubview(messageFrame)
    }

}
