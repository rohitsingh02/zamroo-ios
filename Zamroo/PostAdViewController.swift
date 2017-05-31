//
//  PostAdViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 26/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

// case 44 and 45, flatAmenties brandarray, societyAmenties typearray

import UIKit
import MessageUI
import SCLAlertView


class PostAdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SelectCategoryDelegate,UITextFieldDelegate{


    @IBOutlet var tableView: UITableView!
    
    var adTitle = ""
    var adDescription = ""
    var adTitle1 = ""
    var adDescription1 = ""
    
    
    
    var subCategory:JSON = []
   
    var isReachedFromSubCategorySegue = false
    var section0CellHeight = 0.0
    var section1CellHeight = 0.0
    var brandArray = [String]()
    var floorArray = [String]()
    var typeArray = [String]()
    var parameters = [String:AnyObject]()
    var condition = "New"
    var sellerType = "Individual"
    var brand = ""
    var operatingSystem = ""
    var simSlots = ""
    var size = ""
    var ram = ""
    var camera = ""
    var productType = ""
    var productType1 = ""
    var megaPixelType = ""
    var priceAttribute = ""
    var selectedBrand = ""
    var noOfFloor = ""
    var totalFloor = ""
    var type = ""
    var subCategoryId = 0
    var categoryId = 0
    var price = 0
    var state = 0
    var city = 0
    var flatAmentiesArray = [String]()
    var societyAmentiesArray = [String]()
    
    var screenSize = ""
    var hardDisk = ""
    var processor = ""
    var securityDeposit = 0
    
    
    var connectivity  = [1:false,2:false,3:false,4:false,5:false,6:false]
    var connectivityButtonArray = ["2G","3G","4G","Wi-Fi","Bluetooth","GPS"]
    
    var accessories = [7:false,8:false,9:false,10:false]
    var accessoriesButtonArray = ["Memory Card","Headphones","Charger","Datacable"]

    var currentButtonForConditionType : DesignableButton?
    var currentButtonForSellerType : DesignableButton?
    var currentButtonForOperatingSystem : DesignableButton? = nil
    var currentButtonForSimSlots : DesignableButton? = nil
    var currentButtonForSize : DesignableButton? = nil
    var currentButtonForCamera : DesignableButton? = nil
    var currentButtonForRam : DesignableButton? = nil
    var currentButtonForProductType : DesignableButton? = nil
    var currentButtonForMegaPixelType : DesignableButton? = nil
   
    var isSelectBrand = false
    var isTotalFloor = false
    var isType = false
    var isMultipleSelection = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let statusBarView: UIView = UIView(frame: StringHelper().CGRectMake(0.0, 0.0, UIScreen.main.bounds.width, 20.0))
        statusBarView.backgroundColor = UIColor(colorLiteralRed: 41.0/255.0, green: 116.0/255.0, blue: 118.0/255.0, alpha: 1.0)
        view.addSubview(statusBarView)
        

       tableView.delegate = self
       tableView.dataSource = self
       tableView.tableFooterView = UIView() 
       tableView.estimatedRowHeight = 800; // put max you expect here.
        
       tableView.rowHeight = UITableViewAutomaticDimension;
       self.hideKeyboardWhenTappedAround()
       tableView.register(UINib(nibName: "PostAdHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PostAdHeaderTableViewCell")
       state = LocalStore.getStateId()!
       city = LocalStore.getCityId()!
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName:String?
        switch (section)
        {
        case 0:
            break;
        case 1:
            sectionName = "REQUIRED DETAILS";
            break;
        default:
            sectionName = "REQUIRED DETAILS";
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
            return 44
        default:
            return 0
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 1 && textField.text != nil{
                 adTitle = textField.text!
        }else if textField.tag == 2 && textField.text != nil{
                 adDescription = textField.text!
        }else if textField.tag == 3 && textField.text != nil{
                 price = Int(textField.text!)!
        }
        else if textField.tag == 4 && textField.text != nil{
            screenSize = textField.text!
        }
        else if textField.tag == 5 && textField.text != nil{
            ram = textField.text!
        }
        else if textField.tag == 6 && textField.text != nil{
            hardDisk = textField.text!
        }
        else if textField.tag == 7 && textField.text != nil{
            processor = textField.text!
        }
        else if textField.tag == 8 && textField.text != nil{
            securityDeposit = Int(textField.text!)!
        } else if textField.tag == 9 && textField.text != nil{
            adTitle1 = textField.text!
        }else if textField.tag == 10 && textField.text != nil{
            adDescription1 = textField.text!
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0{
        
            let cellIdentifier = "PostAdHeaderTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostAdHeaderTableViewCell
            
            cell.delegate = self
            
               section0CellHeight = Double(cell.cellXibHeight.constant)
            
            
            cell.categoryHeaderLabel.isHidden = true
            cell.categoryValueLabel.isHidden = true
            
            if isReachedFromSubCategorySegue{
            
                cell.selectCategoryLabel.isHidden = true
                cell.categoryHeaderLabel.text = "Category"
                cell.categoryHeaderLabel.isHidden = false
                cell.categoryValueLabel.text = subCategory["category_name"].stringValue
                cell.categoryValueLabel.isHidden = false
                
            }
            
            cell.adTitleTextField.delegate = self
            cell.adDescriptionTextField.delegate = self
            
            return cell
            
        }
     
        else if isReachedFromSubCategorySegue &&  indexPath.section == 1{
            LocalStore.saveSubCategoryId(subCategory["sub_category_id"].intValue)
            
            
                if subCategory["sub_category_id"].intValue == 1{
                 
                    
                    tableView.register(UINib(nibName: "MobileTableViewCell", bundle: nil), forCellReuseIdentifier: "MobileTableViewCell")
                    
                    let cellIdentifier = "MobileTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MobileTableViewCell
                    section1CellHeight = Double(cell.mobileXibHeight.constant)
                  
                    cell.enterPriceTextField.iconColor = UIColor.darkGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.darkGray
//                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    return cell
                }
                else if subCategory["sub_category_id"].intValue == 2{
              
                     tableView.register(UINib(nibName: "TabletTableViewCell", bundle: nil), forCellReuseIdentifier: "TabletTableViewCell")
                    let cellIdentifier = "TabletTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TabletTableViewCell
                     section1CellHeight = Double(cell.tabletXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    let condition = self.condition
                    let sellerType = self.sellerType
                    let selectBrand = self.brand
                    let operatingSystem = self.operatingSystem
                    let simSlots = self.simSlots
                    let size = self.size
                    let camera = self.camera
                    let ram = self.ram
                 
                    
                    print(condition + sellerType + operatingSystem + simSlots + size + camera + selectBrand + ram)
                    
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if (subCategory["sub_category_id"].intValue == 3 || subCategory["sub_category_id"].intValue == 21 || subCategory["sub_category_id"].intValue == 22 || subCategory["sub_category_id"].intValue == 23 || subCategory["sub_category_id"].intValue == 24 ||
                    subCategory["sub_category_id"].intValue == 95 ||
                    subCategory["sub_category_id"].intValue == 96 ||
                    subCategory["sub_category_id"].intValue == 26){
                
                     tableView.register(UINib(nibName: "AccessoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "AccessoriesTableViewCell")
                    let cellIdentifier = "AccessoriesTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccessoriesTableViewCell
                     section1CellHeight = Double(cell.accessoriesXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                      cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    let condition = self.condition
                    let sellerType = self.sellerType
                  
                    
                    print(condition + sellerType)
                    
                    
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 14{
                
                     tableView.register(UINib(nibName: "LaptopAndComputersTableViewCell", bundle: nil), forCellReuseIdentifier: "LaptopAndComputersTableViewCell")
                    let cellIdentifier = "LaptopAndComputersTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LaptopAndComputersTableViewCell
                     section1CellHeight = Double(cell.laptopAndComputerXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    if screenSize != ""{
                     cell.screenSizeTextField.text = screenSize
                    }
                    if ram != ""{
                      cell.ramTextField.text = ram
                    }
                    
                    if hardDisk != "" {
                      cell.hardDiskTextField.text = hardDisk
                    }
                    if processor != ""{
                     cell.processorTextField.text = processor
                    }
                    
                    cell.screenSizeTextField.delegate = self
                    cell.ramTextField.delegate = self
                    cell.hardDiskTextField.delegate = self
                    cell.processorTextField.delegate = self
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton

                    cell.delegate = self
                
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 15 || subCategory["sub_category_id"].intValue == 17 || subCategory["sub_category_id"].intValue == 19 {
                 
                     tableView.register(UINib(nibName: "ComputerPeripheralsTableViewCell", bundle: nil), forCellReuseIdentifier: "ComputerPeripheralsTableViewCell")
                    let cellIdentifier = "ComputerPeripheralsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ComputerPeripheralsTableViewCell
                     section1CellHeight = Double(cell.computerPeripheralsXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{

                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Product Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    
                    cell.delegate = self
                    return cell
                
                }
                else if subCategory["sub_category_id"].intValue == 16{
                
                     tableView.register(UINib(nibName: "TvAndAccessoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "TvAndAccessoriesTableViewCell")
                    let cellIdentifier = "TvAndAccessoriesTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TvAndAccessoriesTableViewCell
                    
                     section1CellHeight = Double(cell.tvAndAccessoriesXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                      cell.screenSizeTextField.text = screenSize
                    }
                    cell.screenSizeTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    cell.productTypeHeaderLabel.isHidden = true
                    cell.productTypeValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectProductTypeLabel.isHidden = true
                        cell.productTypeHeaderLabel.text = "Product Type"
                        cell.productTypeHeaderLabel.isHidden = false
                        cell.productTypeValueLabel.text = productType
                        cell.productTypeValueLabel.isHidden = false
                    }
                    
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton

                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 18{
                
                     tableView.register(UINib(nibName: "CameraTableViewCell", bundle: nil), forCellReuseIdentifier: "CameraTableViewCell")
                    let cellIdentifier = "CameraTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CameraTableViewCell
                    
                     section1CellHeight = Double(cell.cameraXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.makeHeaderLabel.isHidden = true
                    cell.makeValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectMakeLabel.isHidden = true
                        cell.makeHeaderLabel.text = "Make"
                        cell.makeHeaderLabel.isHidden = false
                        cell.makeValueLabel.text = selectedBrand
                        cell.makeValueLabel.isHidden = false
                    }
                    
                    cell.productTypeHeaderLabel.isHidden = true
                    cell.productTypeValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectProductTypeLabel.isHidden = true
                        cell.productTypeHeaderLabel.text = "Product Type"
                        cell.productTypeHeaderLabel.isHidden = false
                        cell.productTypeValueLabel.text = productType
                        cell.productTypeValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 20{
                   
                     tableView.register(UINib(nibName: "GamingAndConsolesTableViewCell", bundle: nil), forCellReuseIdentifier: "GamingAndConsolesTableViewCell")
                    let cellIdentifier = "GamingAndConsolesTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GamingAndConsolesTableViewCell
                    
                     section1CellHeight = Double(cell.gamingAndConsoleXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    cell.productTypeHeaderLabel.isHidden = true
                    cell.productTypeValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectProductTypeLabel.isHidden = true
                        cell.productTypeHeaderLabel.text = "Product Type"
                        cell.productTypeHeaderLabel.isHidden = false
                        cell.productTypeValueLabel.text = selectedBrand
                        cell.productTypeValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 44{
                  
                     tableView.register(UINib(nibName: "HouseAndApartmentForRentTableViewCell", bundle: nil), forCellReuseIdentifier: "HouseAndApartmentForRentTableViewCell")
                    let cellIdentifier = "HouseAndApartmentForRentTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HouseAndApartmentForRentTableViewCell
                    section1CellHeight = Double(cell.houseAndApartmentForRentXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    cell.securityDepositTextField.iconColor = UIColor.lightGray
                    cell.securityDepositTextField.selectedIconColor = UIColor.green
                    cell.securityDepositTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.securityDepositTextField.iconText = "\u{20B9}"
                    
                    if securityDeposit != 0{
                        cell.securityDepositTextField.text = "\(securityDeposit)"
                    }
                    cell.securityDepositTextField.delegate = self
                    
                    cell.propertyTypeHeaderLabel.isHidden = true
                    cell.propertyTypeValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectPropertyTypeLabel.isHidden = true
                        cell.propertyTypeHeaderLabel.text = "Property Type"
                        cell.propertyTypeHeaderLabel.isHidden = false
                        cell.propertyTypeValueLabel.text = productType
                        cell.propertyTypeValueLabel.isHidden = false
                    }
                    
                    cell.expYearHeaderLabel.isHidden = true
                    cell.expYearValueLabel.isHidden = true
                    
                    if noOfFloor != ""{
                        
                        cell.expYearLabel.isHidden = true
                        cell.expYearHeaderLabel.text = "Floor Number"
                        cell.expYearHeaderLabel.isHidden = false
                        cell.expYearValueLabel.text = noOfFloor
                        cell.expYearValueLabel.isHidden = false
                    }
                    
                    cell.expmonthHeaderLabel.isHidden = true
                    cell.expMonthValueLabel.isHidden = true
                    
                    if totalFloor != ""{
                        
                        cell.expmonthLabel.isHidden = true
                        cell.expmonthHeaderLabel.text = "Total Floor's"
                        cell.expmonthHeaderLabel.isHidden = false
                        cell.expMonthValueLabel.text = totalFloor
                        cell.expMonthValueLabel.isHidden = false
                    }
                    
                    cell.flatAmentiesHeaderLabel.isHidden = true
                    cell.flatAmentiesValueLabel.isHidden = true
                    
                    if flatAmentiesArray.count > 0{
                        
                        cell.flatAmentiesLabel.isHidden = true
                        cell.flatAmentiesHeaderLabel.text = "Flat Amenities"
                        cell.flatAmentiesHeaderLabel.isHidden = false
                        cell.flatAmentiesValueLabel.text = "(" + "\(flatAmentiesArray)" + ")"
                        cell.flatAmentiesValueLabel.isHidden = false
                    }
                    
                    cell.societyAmentiesHeaderLabel.isHidden = true
                    cell.societyAmentiesValueLabel.isHidden = true
                    
                    if societyAmentiesArray.count > 0{
                        
                        cell.societyAmentiesLabel.isHidden = true
                        cell.societyAmentiesHeaderLabel.text = "Society Amenities"
                        cell.societyAmentiesHeaderLabel.isHidden = false
                        cell.societyAmentiesValueLabel.text = "(" + "\(societyAmentiesArray)" + ")"
                        cell.societyAmentiesValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 45{
                  
                     tableView.register(UINib(nibName: "HouseAndApartmentsForSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "HouseAndApartmentsForSaleTableViewCell")
                    let cellIdentifier = "HouseAndApartmentsForSaleTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HouseAndApartmentsForSaleTableViewCell
                     section1CellHeight = Double(cell.houseANdApartmentForSaleXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.securityDepositTextField.iconColor = UIColor.lightGray
                    cell.securityDepositTextField.selectedIconColor = UIColor.green
                    cell.securityDepositTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.securityDepositTextField.iconText = "\u{20B9}"
                    
                    
                    if securityDeposit != 0{
                        cell.securityDepositTextField.text = "\(securityDeposit)"
                    }
                    cell.securityDepositTextField.delegate = self
                    
                    cell.propertyTypeHeaderLabel.isHidden = true
                    cell.propertyTypeValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectPropertyTypeLabel.isHidden = true
                        cell.propertyTypeHeaderLabel.text = "Property Type"
                        cell.propertyTypeHeaderLabel.isHidden = false
                        cell.propertyTypeValueLabel.text = productType
                        cell.propertyTypeValueLabel.isHidden = false
                    }
                    
                    cell.expYearHeaderLabel.isHidden = true
                    cell.expYearValueLabel.isHidden = true
                    
                    if noOfFloor != ""{
                        
                        cell.expYearLabel.isHidden = true
                        cell.expYearHeaderLabel.text = "Floor Number"
                        cell.expYearHeaderLabel.isHidden = false
                        cell.expYearValueLabel.text = noOfFloor
                        cell.expYearValueLabel.isHidden = false
                    }
                    
                    cell.expmonthHeaderLabel.isHidden = true
                    cell.expMonthValueLabel.isHidden = true
                    
                    if totalFloor != ""{
                        
                        cell.expmonthLabel.isHidden = true
                        cell.expmonthHeaderLabel.text = "Total Floor's"
                        cell.expmonthHeaderLabel.isHidden = false
                        cell.expMonthValueLabel.text = totalFloor
                        cell.expMonthValueLabel.isHidden = false
                    }
                    
                    cell.flatAmentiesHeaderLabel.isHidden = true
                    cell.flatAmentiesValueLabel.isHidden = true
                    
                    if flatAmentiesArray.count > 0{
                        
                        cell.flatAmentiesLabel.isHidden = true
                        cell.flatAmentiesHeaderLabel.text = "Flat Amenities"
                        cell.flatAmentiesHeaderLabel.isHidden = false
                        cell.flatAmentiesValueLabel.text = "(" + "\(flatAmentiesArray)" + ")"
                        cell.flatAmentiesValueLabel.isHidden = false
                    }
                    
                    cell.societyAmentiesHeaderLabel.isHidden = true
                    cell.societyAmentiesValueLabel.isHidden = true
                    
                    if societyAmentiesArray.count > 0{
                        
                        cell.societyAmentiesLabel.isHidden = true
                        cell.societyAmentiesHeaderLabel.text = "Society Amenities"
                        cell.societyAmentiesHeaderLabel.isHidden = false
                        cell.societyAmentiesValueLabel.text = "(" + "\(societyAmentiesArray)" + ")"
                        cell.societyAmentiesValueLabel.isHidden = false
                    }

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
            
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 46{
                   
                     tableView.register(UINib(nibName: "LandAndPlotTableViewCell", bundle: nil), forCellReuseIdentifier: "LandAndPlotTableViewCell")
                    let cellIdentifier = "LandAndPlotTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LandAndPlotTableViewCell
                     section1CellHeight = Double(cell.landAndPlotXibHeight.constant)
                    
                    cell.enterPriceEditText.iconColor = UIColor.lightGray
                    cell.enterPriceEditText.selectedIconColor = UIColor.green
                    cell.enterPriceEditText.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceEditText.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceEditText.text = "\(price)"
                    }
                    cell.enterPriceEditText.delegate = self

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton

                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 47{
                 
                     tableView.register(UINib(nibName: "PayingGuestTableViewCell", bundle: nil), forCellReuseIdentifier: "PayingGuestTableViewCell")
                    let cellIdentifier = "PayingGuestTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PayingGuestTableViewCell
                     section1CellHeight = Double(cell.payingGuestXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    
                    cell.securityDepositTextField.iconColor = UIColor.lightGray
                    cell.securityDepositTextField.selectedIconColor = UIColor.green
                    cell.securityDepositTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.securityDepositTextField.iconText = "\u{20B9}"
                    
                
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    if securityDeposit != 0{
                      cell.securityDepositTextField.text = "\(securityDeposit)"
                    }
                    
                    cell.enterPriceTextField.delegate = self
                    cell.securityDepositTextField.delegate = self
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    
                    
                    
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 48 || subCategory["sub_category_id"].intValue == 49 {
                 
                     tableView.register(UINib(nibName: "CommercialPropertyForRentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommercialPropertyForRentTableViewCell")
                    let cellIdentifier = "CommercialPropertyForRentTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommercialPropertyForRentTableViewCell
                     section1CellHeight = Double(cell.commercialPropertyForRentXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.propertyTypeHeaderLabel.isHidden = true
                    cell.propertyTypeValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectPropertyTypeLabel.isHidden = true
                        cell.propertyTypeHeaderLabel.text = "Property Type"
                        cell.propertyTypeHeaderLabel.isHidden = false
                        cell.propertyTypeValueLabel.text = selectedBrand
                        cell.propertyTypeValueLabel.isHidden = false
                    }
                    
                    cell.areaTypeHeaderLabel.isHidden = true
                    cell.areaTypeValueLabel.isHidden = true
                    
                
                    if productType != ""{
                        
                        cell.selectAreaTypeLabel.isHidden = true
                        cell.areaTypeHeaderLabel.text = "Area(Sq. Feet)"
                        cell.areaTypeHeaderLabel.isHidden = false
                        cell.areaTypeValueLabel.text = productType
                        cell.areaTypeValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton

                    cell.delegate = self
                    
                    return cell
               
                    
                }
                else if subCategory["sub_category_id"].intValue == 50{
   
                     tableView.register(UINib(nibName: "ServicedApartmentsTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicedApartmentsTableViewCell")
                    let cellIdentifier = "ServicedApartmentsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ServicedApartmentsTableViewCell
                    section1CellHeight = Double(cell.servicedApartmentsXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                     cell.enterPriceTextField.text = "\(price)"
                    }
                    
                    cell.enterPriceTextField.delegate = self

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 51{
                    
                     tableView.register(UINib(nibName: "VacationRentalsTableViewCell", bundle: nil), forCellReuseIdentifier: "VacationRentalsTableViewCell")
                    let cellIdentifier = "VacationRentalsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VacationRentalsTableViewCell
                     section1CellHeight = Double(cell.vacationRentalsXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    let sellerType = self.sellerType
                   
                    let noOfRooms = self.camera
                    
                    print(sellerType + noOfRooms)
                 
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 126 ||
                    subCategory["sub_category_id"].intValue == 127 ||
                    subCategory["sub_category_id"].intValue == 128 ||
                    subCategory["sub_category_id"].intValue == 129 ||
                    subCategory["sub_category_id"].intValue == 130 ||
                    subCategory["sub_category_id"].intValue == 131 ||
                    subCategory["sub_category_id"].intValue == 132 ||
                    subCategory["sub_category_id"].intValue == 133 ||
                    subCategory["sub_category_id"].intValue == 158 ||
                    subCategory["sub_category_id"].intValue == 159 ||
                    subCategory["sub_category_id"].intValue == 160 ||
                    subCategory["sub_category_id"].intValue == 161 ||
                    subCategory["sub_category_id"].intValue == 162 ||
                    subCategory["sub_category_id"].intValue == 163
                {
                  
                     tableView.register(UINib(nibName: "FinanceBankingAndInsuranceTableViewCell", bundle: nil), forCellReuseIdentifier: "FinanceBankingAndInsuranceTableViewCell")
                    let cellIdentifier = "FinanceBankingAndInsuranceTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FinanceBankingAndInsuranceTableViewCell
                     section1CellHeight = Double(cell.financeBankingAndInsuranceXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Type Of Job"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
       
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.locationTextField.text = screenSize
                    }
                    if ram != ""{
                        cell.timingTextField.text = ram
                    }
                    
                    if hardDisk != "" {
                        cell.experienceTextField.text = hardDisk
                    }
                    if processor != ""{
                        cell.skillsTextField.text = processor
                    }
                    cell.locationTextField.delegate = self
                    cell.timingTextField.delegate = self
                    cell.experienceTextField.delegate = self
                    cell.skillsTextField.delegate = self
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    let advertiseBy = self.camera
                    let typeOfJob = self.brand
                    let location = cell.locationTextField.text
                    let timing = cell.timingTextField.text
                    let experience = cell.experienceTextField.text
                    let skills = cell.skillsTextField.text
                  
                    print (advertiseBy  + typeOfJob + location! + timing! + experience! + skills!)
                    cell.delegate = self
                    
                    return cell
              
                    
                }
                else if subCategory["sub_category_id"].intValue == 4 ||
                    subCategory["sub_category_id"].intValue == 11{
                
                     tableView.register(UINib(nibName: "CarsTableViewCell", bundle: nil), forCellReuseIdentifier: "CarsTableViewCell")
                    let cellIdentifier = "CarsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CarsTableViewCell
                    section1CellHeight = Double(cell.carXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.kmsDrivenTextField.text = screenSize
                    }
                    cell.kmsDrivenTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Make"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    let transmissionType = self.condition
                    let sellerType = self.sellerType
                    let fuelType = self.operatingSystem
                    let ownerType = self.size
                    let insuranceType = self.simSlots
                    let registrationType = self.camera
                    let make = self.brand
                    print (sellerType  +  fuelType + ownerType + insuranceType +  registrationType + transmissionType + make)
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 5 ||
                    subCategory["sub_category_id"].intValue == 6{
                  
                     tableView.register(UINib(nibName: "MotorCyclesTableViewCell", bundle: nil), forCellReuseIdentifier: "MotorCyclesTableViewCell")
                    let cellIdentifier = "MotorCyclesTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MotorCyclesTableViewCell
                    section1CellHeight = Double(cell.motorCycleXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.kmsDrivenTextField.text = screenSize
                    }
                    cell.kmsDrivenTextField.delegate = self
                    
                    
                    cell.ModelYearHeaderLabel.isHidden = true
                    cell.ModelYearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectModelYearLabel.isHidden = true
                        cell.ModelYearHeaderLabel.text = "Model Year"
                        cell.ModelYearHeaderLabel.isHidden = false
                        cell.ModelYearValueLabel.text = productType
                        cell.ModelYearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Make"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    let sellerType = self.sellerType
                    let ownerType = self.size
                    let kmsDriven = cell.kmsDrivenTextField.text
                    let insuranceType = self.simSlots
                    let registrationType = self.camera
                    let make = self.brand
                    let modelYear = self.productType
                    print (sellerType   + ownerType + insuranceType +  registrationType + make + modelYear  + kmsDriven! )
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 7 {
                 
                     tableView.register(UINib(nibName: "BicycleTableViewCell", bundle: nil), forCellReuseIdentifier: "BicycleTableViewCell")
                    let cellIdentifier = "BicycleTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BicycleTableViewCell
                    section1CellHeight = Double(cell.bicycleXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Year"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 8 {
                 
                     tableView.register(UINib(nibName: "HeavyVehiclesTableViewCell", bundle: nil), forCellReuseIdentifier: "HeavyVehiclesTableViewCell")
                    let cellIdentifier = "HeavyVehiclesTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HeavyVehiclesTableViewCell
                    section1CellHeight = Double(cell.heavyVehiclesXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Year"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = productType
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 10 {
                
                     tableView.register(UINib(nibName: "TractorTableViewCell", bundle: nil), forCellReuseIdentifier: "TractorTableViewCell")
                    let cellIdentifier = "TractorTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TractorTableViewCell
                    section1CellHeight = Double(cell.tractorXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    if screenSize != ""{
                        cell.hoursDrivenTextField.text = screenSize
                    }
                    cell.hoursDrivenTextField.delegate = self
                    cell.ModelYearHeaderLabel.isHidden = true
                    cell.ModelYearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectModelYearLabel.isHidden = true
                        cell.ModelYearHeaderLabel.text = "Model Year"
                        cell.ModelYearHeaderLabel.isHidden = false
                        cell.ModelYearValueLabel.text = productType
                        cell.ModelYearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Make"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
        
           
                    currentButtonForSellerType = cell.individualButton
                    
                 
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 12 {
                  
                     tableView.register(UINib(nibName: "CommercialTransportTableViewCell", bundle: nil), forCellReuseIdentifier: "CommercialTransportTableViewCell")
                    let cellIdentifier = "CommercialTransportTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommercialTransportTableViewCell
                    section1CellHeight = Double(cell.commercialTransportXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    if screenSize != ""{
                        cell.kmsDrivenTextField.text = screenSize
                    }
                    cell.kmsDrivenTextField.delegate = self
                    
                    
                    cell.ModelYearHeaderLabel.isHidden = true
                    cell.ModelYearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectModelYearLabel.isHidden = true
                        cell.ModelYearHeaderLabel.text = "Model Year"
                        cell.ModelYearHeaderLabel.isHidden = false
                        cell.ModelYearValueLabel.text = productType
                        cell.ModelYearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    let transmissionType = self.condition
                    let sellerType = self.sellerType
                    let fuelType = self.operatingSystem
                    let ownerType = self.size
                    let kmsDriven = cell.kmsDrivenTextField.text
                    let insuranceType = self.simSlots
                    let registrationType = self.camera
                    let type = self.brand
                    let modelYear = self.productType
                    print (sellerType  +  fuelType + ownerType + insuranceType +  registrationType + transmissionType + type + modelYear  + kmsDriven! )
                    cell.delegate = self
                    
                    
                    return cell
                 
                    
                }
                else if subCategory["sub_category_id"].intValue == 13 ||
                    subCategory["sub_category_id"].intValue == 169 ||
                    subCategory["sub_category_id"].intValue == 97 ||
                    subCategory["sub_category_id"].intValue == 98 ||
                    subCategory["sub_category_id"].intValue == 99 ||
                    subCategory["sub_category_id"].intValue == 100 ||
                    subCategory["sub_category_id"].intValue == 101 ||
                    subCategory["sub_category_id"].intValue == 102{
                
                     tableView.register(UINib(nibName: "SparePartsAndAccessoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "SparePartsAndAccessoriesTableViewCell")
                    let cellIdentifier = "SparePartsAndAccessoriesTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SparePartsAndAccessoriesTableViewCell
                    section1CellHeight = Double(cell.sparePartsAndAccessoriesXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    let sellerType = self.sellerType
                    
                    print (sellerType)
                    cell.delegate = self
            
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 25 {
                  
                     tableView.register(UINib(nibName: "AirConditionerTableViewCell", bundle: nil), forCellReuseIdentifier: "AirConditionerTableViewCell")
                    let cellIdentifier = "AirConditionerTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AirConditionerTableViewCell
                    section1CellHeight = Double(cell.airConditionerXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    cell.typeHeaderLabel.isHidden = true
                    cell.typeValueLabel.isHidden = true
                    
                    if type != ""{
                        
                        cell.selectTypeLabel.isHidden = true
                        cell.typeHeaderLabel.text = "Select Type"
                        cell.typeHeaderLabel.isHidden = false
                        cell.typeValueLabel.text = type
                        cell.typeValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    
                    let condition = self.condition
                    let sellerType = self.sellerType
                    let selectBrand = self.brand
                    let ton = self.operatingSystem
                    let selectType = self.type
                    let year = self.productType
                    print (condition + sellerType  + selectBrand + selectType + ton + year)
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 26 {
                    
                     tableView.register(UINib(nibName: "RefrigeratorsTableViewCell", bundle: nil), forCellReuseIdentifier: "RefrigeratorsTableViewCell")
                    let cellIdentifier = "RefrigeratorsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RefrigeratorsTableViewCell
                    section1CellHeight = Double(cell.refrigeratorXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    cell.storageVolumeHeaderLabel.isHidden = true
                    cell.storageVolumeValueLabel.isHidden = true
                    
                    if type != ""{
                        
                        cell.selectStorageVolumeLabel.isHidden = true
                        cell.storageVolumeHeaderLabel.text = "Storage Volume"
                        cell.storageVolumeHeaderLabel.isHidden = false
                        cell.storageVolumeValueLabel.text = type
                        cell.storageVolumeValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    
                    return cell
               
                }
                else if subCategory["sub_category_id"].intValue == 27 {
                 
                     tableView.register(UINib(nibName: "AirCoolersTableViewCell", bundle: nil), forCellReuseIdentifier: "AirCoolersTableViewCell")
                    let cellIdentifier = "AirCoolersTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AirCoolersTableViewCell
                    section1CellHeight = Double(cell.airCoolerXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                   
                    
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                  
                    cell.delegate = self
                    
                    return cell
                 
                    
                }
                else if subCategory["sub_category_id"].intValue == 28 {
                  
                     tableView.register(UINib(nibName: "FansTableViewCell", bundle: nil), forCellReuseIdentifier: "FansTableViewCell")
                    let cellIdentifier = "FansTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FansTableViewCell
                    section1CellHeight = Double(cell.fansXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    cell.typeHeaderLabel.isHidden = true
                    cell.typeValueLabel.isHidden = true
                    
                    if type != ""{
                        
                        cell.selectTypeLabel.isHidden = true
                        cell.typeHeaderLabel.text = "Select Type"
                        cell.typeHeaderLabel.isHidden = false
                        cell.typeValueLabel.text = type
                        cell.typeValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                   
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 29 {
                    
                     tableView.register(UINib(nibName: "GeysersTableViewCell", bundle: nil), forCellReuseIdentifier: "GeysersTableViewCell")
                    let cellIdentifier = "GeysersTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GeysersTableViewCell
                    section1CellHeight = Double(cell.geysersXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
           
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton

                    cell.delegate = self
                    
                    return cell
                
                    
                }
                else if subCategory["sub_category_id"].intValue == 30 {
                    
                     tableView.register(UINib(nibName: "WashingMachineTableViewCell", bundle: nil), forCellReuseIdentifier: "WashingMachineTableViewCell")
                    let cellIdentifier = "WashingMachineTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WashingMachineTableViewCell
                    section1CellHeight = Double(cell.washingMachineXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                 
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
           
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 31 {
               
                     tableView.register(UINib(nibName: "WaterPurifierTableViewCell", bundle: nil), forCellReuseIdentifier: "WaterPurifierTableViewCell")
                    let cellIdentifier = "WaterPurifierTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WaterPurifierTableViewCell
                    section1CellHeight = Double(cell.waterPurifierXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
          
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    
                    let condition = self.condition
                    let sellerType = self.sellerType
                    let selectBrand = self.brand
                    let year = self.productType
                    print (condition + sellerType + selectBrand + year)
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 32 {
                    
                     tableView.register(UINib(nibName: "VaccumCleanersTableViewCell", bundle: nil), forCellReuseIdentifier: "VaccumCleanersTableViewCell")
                    let cellIdentifier = "VaccumCleanersTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! VaccumCleanersTableViewCell
                    section1CellHeight = Double(cell.vaccumCleanersXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    
                    cell.enterPriceTextField.delegate = self

                    
                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                  
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 33 ||
                    subCategory["sub_category_id"].intValue == 34 ||
                    subCategory["sub_category_id"].intValue == 35 ||
                    subCategory["sub_category_id"].intValue == 37 ||
                    subCategory["sub_category_id"].intValue == 38 ||
                    subCategory["sub_category_id"].intValue == 39 ||
                    subCategory["sub_category_id"].intValue == 40{
                   
                     tableView.register(UINib(nibName: "FurnitureHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "FurnitureHomeTableViewCell")
                    let cellIdentifier = "FurnitureHomeTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FurnitureHomeTableViewCell
                    section1CellHeight = Double(cell.furnitureHomeXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                 
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 36 {
                    
                     tableView.register(UINib(nibName: "MicrowaveTableViewCell", bundle: nil), forCellReuseIdentifier: "MicrowaveTableViewCell")
                    let cellIdentifier = "MicrowaveTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MicrowaveTableViewCell
                    section1CellHeight = Double(cell.microwaveXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.yearHeaderLabel.isHidden = true
                    cell.yearValueLabel.isHidden = true
                    if productType != ""{
                        
                        cell.selectYearLabel.isHidden = true
                        cell.yearHeaderLabel.text = "Select Year"
                        cell.yearHeaderLabel.isHidden = false
                        cell.yearValueLabel.text = productType
                        cell.yearValueLabel.isHidden = false
                    }
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Brand"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                 
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 52 ||
                    subCategory["sub_category_id"].intValue == 53 ||
                    subCategory["sub_category_id"].intValue == 55 ||
                    subCategory["sub_category_id"].intValue == 76 ||
                    subCategory["sub_category_id"].intValue == 77{
                    
                     tableView.register(UINib(nibName: "PetsForSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "PetsForSaleTableViewCell")
                    let cellIdentifier = "PetsForSaleTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PetsForSaleTableViewCell
                    section1CellHeight = Double(cell.petsForSaleXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                   
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    currentButtonForSellerType = cell.individualButton
                
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 54 ||
                    subCategory["sub_category_id"].intValue == 170 ||
                    subCategory["sub_category_id"].intValue == 68{
                    
                     tableView.register(UINib(nibName: "MissingLostAndFoundTableViewCell", bundle: nil), forCellReuseIdentifier: "MissingLostAndFoundTableViewCell")
                    let cellIdentifier = "MissingLostAndFoundTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MissingLostAndFoundTableViewCell
                    
                   section1CellHeight = Double(cell.missingLostAndFoundXibHeight.constant)
                   
                    let selectType = self.brand
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
             
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 115 {
                    
                     tableView.register(UINib(nibName: "MaidsAndDomesticHelpTableViewCell", bundle: nil), forCellReuseIdentifier: "MaidsAndDomesticHelpTableViewCell")
                    let cellIdentifier = "MaidsAndDomesticHelpTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MaidsAndDomesticHelpTableViewCell
                    section1CellHeight = Double(cell.maidAndDomesticHelpXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    
                    cell.salaryOfferedTextField.iconColor = UIColor.darkGray
                    cell.salaryOfferedTextField.selectedIconColor = UIColor.darkGray
                    cell.salaryOfferedTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.salaryOfferedTextField.iconText = "\u{20B9}"
                   
                    if securityDeposit != 0{
                        cell.salaryOfferedTextField.text = "\(securityDeposit)"
                    }
                    cell.salaryOfferedTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
            
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                   
                    cell.delegate = self
                    
                    return cell
                
                    
                }
                else if subCategory["sub_category_id"].intValue == 116 ||
                    subCategory["sub_category_id"].intValue == 118 ||
                    subCategory["sub_category_id"].intValue == 119 ||
                    subCategory["sub_category_id"].intValue == 125 ||
                    subCategory["sub_category_id"].intValue == 145 ||
                    subCategory["sub_category_id"].intValue == 134 ||
                    subCategory["sub_category_id"].intValue == 135 ||
                    subCategory["sub_category_id"].intValue == 136 ||
                    subCategory["sub_category_id"].intValue == 137 ||
                    subCategory["sub_category_id"].intValue == 139 ||
                    subCategory["sub_category_id"].intValue == 140{
                    
                     tableView.register(UINib(nibName: "HomeImprovementAndRepairTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeImprovementAndRepairTableViewCell")
                    let cellIdentifier = "HomeImprovementAndRepairTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeImprovementAndRepairTableViewCell
                    section1CellHeight = Double(cell.homeImprovementAndRepairXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                  
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 171 ||
                    subCategory["sub_category_id"].intValue == 117 ||
                    subCategory["sub_category_id"].intValue == 120 ||
                    subCategory["sub_category_id"].intValue == 121 ||
                    subCategory["sub_category_id"].intValue == 122 ||
                    subCategory["sub_category_id"].intValue == 123 ||
                    subCategory["sub_category_id"].intValue == 124 ||
                    subCategory["sub_category_id"].intValue == 59 ||
                    subCategory["sub_category_id"].intValue == 64 || subCategory["sub_category_id"].intValue == 65 ||
                    subCategory["sub_category_id"].intValue == 72 ||
                    subCategory["sub_category_id"].intValue == 73 ||
                    subCategory["sub_category_id"].intValue == 74{
                    
                     tableView.register(UINib(nibName: "NannyTableViewCell", bundle: nil), forCellReuseIdentifier: "NannyTableViewCell")
                    let cellIdentifier = "NannyTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NannyTableViewCell
                    section1CellHeight = Double(cell.nannyXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    cell.delegate = self
  
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 103 ||
                    subCategory["sub_category_id"].intValue == 104 ||
                    subCategory["sub_category_id"].intValue == 105 ||
                    subCategory["sub_category_id"].intValue == 41 ||
                    subCategory["sub_category_id"].intValue == 42 ||
                    subCategory["sub_category_id"].intValue == 43{
                    
                     tableView.register(UINib(nibName: "MensClothingTableViewCell", bundle: nil), forCellReuseIdentifier: "MensClothingTableViewCell")
                    let cellIdentifier = "MensClothingTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MensClothingTableViewCell
                    section1CellHeight = Double(cell.mensClothingXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                  
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 172 ||
                    subCategory["sub_category_id"].intValue == 179
                {
                     tableView.register(UINib(nibName: "AccessoriesClothingTableViewCell", bundle: nil), forCellReuseIdentifier: "AccessoriesClothingTableViewCell")
                    let cellIdentifier = "AccessoriesClothingTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AccessoriesClothingTableViewCell
                    section1CellHeight = Double(cell.accessoriesClothingXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForConditionType = cell.usedButton
                    currentButtonForSellerType = cell.individualButton
                    
                    let condition = self.condition
                    let sellerType = self.sellerType
                    
                    print (condition + sellerType)
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 56 ||
                    subCategory["sub_category_id"].intValue == 57 ||
                    subCategory["sub_category_id"].intValue == 58 ||
                    subCategory["sub_category_id"].intValue == 60 ||
                    subCategory["sub_category_id"].intValue == 61 ||
                    subCategory["sub_category_id"].intValue == 62 ||
                    subCategory["sub_category_id"].intValue == 63
                {
                     tableView.register(UINib(nibName: "HotelTableViewCell", bundle: nil), forCellReuseIdentifier: "HotelTableViewCell")
                    let cellIdentifier = "HotelTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HotelTableViewCell
                    
                    section1CellHeight = Double(cell.hotelXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    currentButtonForSellerType = cell.individualButton
                    
                    let sellerType = self.sellerType
                    let selectFeatures = self.brand
                    
                    
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if flatAmentiesArray.count > 0{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Flat Amenities"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = "(" + "\(flatAmentiesArray)" + ")"
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 66 ||
                    subCategory["sub_category_id"].intValue == 67  ||
                    subCategory["sub_category_id"].intValue == 141 ||
                    subCategory["sub_category_id"].intValue == 143
                {
                     tableView.register(UINib(nibName: "HomeTutorsTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTutorsTableViewCell")
                    let cellIdentifier = "HomeTutorsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! HomeTutorsTableViewCell
                    section1CellHeight = Double(cell.homeTutorsXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    let selectType = self.brand
                    
                    print(selectType)
                    cell.delegate = self
                    return cell
                
                }
                else if subCategory["sub_category_id"].intValue == 88 ||
                    subCategory["sub_category_id"].intValue == 138 ||
                    subCategory["sub_category_id"].intValue == 142 ||
                    subCategory["sub_category_id"].intValue == 144 ||
                    subCategory["sub_category_id"].intValue == 81 ||
                    subCategory["sub_category_id"].intValue == 82 ||
                    subCategory["sub_category_id"].intValue == 83 ||
                    subCategory["sub_category_id"].intValue == 84 ||
                    subCategory["sub_category_id"].intValue == 85 ||
                    subCategory["sub_category_id"].intValue == 86 ||
                    subCategory["sub_category_id"].intValue == 87 ||
                    subCategory["sub_category_id"].intValue == 89 ||
                    subCategory["sub_category_id"].intValue == 90 ||
                    subCategory["sub_category_id"].intValue == 91 ||
                    subCategory["sub_category_id"].intValue == 92 ||
                    subCategory["sub_category_id"].intValue == 93 ||
                    subCategory["sub_category_id"].intValue == 94 ||
                    subCategory["sub_category_id"].intValue == 78 ||
                    subCategory["sub_category_id"].intValue == 79 ||
                    subCategory["sub_category_id"].intValue == 80 ||
                    subCategory["sub_category_id"].intValue == 152 ||
                    subCategory["sub_category_id"].intValue == 153 ||
                    subCategory["sub_category_id"].intValue == 154 ||
                    subCategory["sub_category_id"].intValue == 155 ||
                    subCategory["sub_category_id"].intValue == 156 ||
                    subCategory["sub_category_id"].intValue == 157{
                    
                     tableView.register(UINib(nibName: "PaintingsTableViewCell", bundle: nil), forCellReuseIdentifier: "PaintingsTableViewCell")
                    let cellIdentifier = "PaintingsTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PaintingsTableViewCell
                    section1CellHeight = Double(cell.paintingsXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    
                    cell.enterPriceTextField.delegate = self
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                  
                    
                    cell.delegate = self
                    
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 70 ||
                    subCategory["sub_category_id"].intValue == 71
                {
                    
                     tableView.register(UINib(nibName: "TaxiTableViewCell", bundle: nil), forCellReuseIdentifier: "TaxiTableViewCell")
                    let cellIdentifier = "TaxiTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TaxiTableViewCell
                    section1CellHeight = Double(cell.taxiXibHeight.constant)
                    
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Make"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
             
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 75
                {
                    
                     tableView.register(UINib(nibName: "JewelleryTableViewCell", bundle: nil), forCellReuseIdentifier: "JewelleryTableViewCell")
                    let cellIdentifier = "JewelleryTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! JewelleryTableViewCell
                    section1CellHeight = Double(cell.jewelleryXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.typeHeaderLabel.isHidden = true
                    cell.typeValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectTypeLabel.isHidden = true
                        cell.typeHeaderLabel.text = "Select Type"
                        cell.typeHeaderLabel.isHidden = false
                        cell.typeValueLabel.text = selectedBrand
                        cell.typeValueLabel.isHidden = false
                    }
                    
                    cell.subTypeHeaderLabel.isHidden = true
                    cell.subTypeValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.selectSubTypeLabel.isHidden = true
                        cell.subTypeHeaderLabel.text = "Select SubType"
                        cell.subTypeHeaderLabel.isHidden = false
                        cell.subTypeValueLabel.text = productType
                        cell.subTypeValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 178 ||
                    subCategory["sub_category_id"].intValue == 146 ||
                    subCategory["sub_category_id"].intValue == 147 ||
                    subCategory["sub_category_id"].intValue == 148 ||
                    subCategory["sub_category_id"].intValue == 176 ||
                    subCategory["sub_category_id"].intValue == 175 ||
                    subCategory["sub_category_id"].intValue == 174 ||
                    subCategory["sub_category_id"].intValue == 149 ||
                    subCategory["sub_category_id"].intValue == 173 ||
                    subCategory["sub_category_id"].intValue == 177
                {
                     tableView.register(UINib(nibName: "AgriculturalTableViewCell", bundle: nil), forCellReuseIdentifier: "AgriculturalTableViewCell")
                    let cellIdentifier = "AgriculturalTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AgriculturalTableViewCell
                    section1CellHeight = Double(cell.agriculturalXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.brandTextField.text = screenSize
                    }
                    cell.brandTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    currentButtonForConditionType = cell.usedButton
                    
                    cell.delegate = self
                    
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 108 ||
                    subCategory["sub_category_id"].intValue == 110
                {
                    
                     tableView.register(UINib(nibName: "BusinessForSaleAndLeaseTableViewCell", bundle: nil), forCellReuseIdentifier: "BusinessForSaleAndLeaseTableViewCell")
                    let cellIdentifier = "BusinessForSaleAndLeaseTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BusinessForSaleAndLeaseTableViewCell
                    section1CellHeight = Double(cell.businessForSaleAndLeaseXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                   
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.typeOfBusinessTextField.text = screenSize
                    }
                    if ram != ""{
                        cell.salesRevenueTextField.text = ram
                    }
                    cell.typeOfBusinessTextField.delegate = self
                    cell.salesRevenueTextField.delegate = self
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                     currentButtonForSellerType = cell.individualButton
                    currentButtonForConditionType = cell.usedButton
                    
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 109
                {
                    
                     tableView.register(UINib(nibName: "AuditionAndCastingTableViewCell", bundle: nil), forCellReuseIdentifier: "AuditionAndCastingTableViewCell")
                    let cellIdentifier = "AuditionAndCastingTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AuditionAndCastingTableViewCell
                    section1CellHeight = Double(cell.auditionAndCastingXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    if screenSize != ""{
                        cell.roleTextField.text = screenSize
                    }
                    if ram != ""{
                        cell.noOfPositionTextField.text = ram
                    }
                    
                    if hardDisk != "" {
                        cell.ageGroupTextField.text = hardDisk
                    }
                    if processor != ""{
                        cell.locationTextField.text = processor
                    }

                    cell.roleTextField.delegate = self
                    cell.noOfPositionTextField.delegate = self
                    cell.ageGroupTextField.delegate = self
                    cell.locationTextField.delegate = self
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
            
                    cell.delegate = self
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 165 ||
                    subCategory["sub_category_id"].intValue == 168 ||
                    subCategory["sub_category_id"].intValue == 166 ||
                    subCategory["sub_category_id"].intValue == 167
                {
                    
                     tableView.register(UINib(nibName: "ActingSchoolTableViewCell", bundle: nil), forCellReuseIdentifier: "ActingSchoolTableViewCell")
                    let cellIdentifier = "ActingSchoolTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ActingSchoolTableViewCell
                    section1CellHeight = Double(cell.actingSchoolXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.locationTextField.text = screenSize
                    }
                    cell.locationTextField.delegate = self
                
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    let location = cell.locationTextField.text
                    
                    print(location!)
                    
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 111
                {
                     tableView.register(UINib(nibName: "ModelPortfolioTableViewCell", bundle: nil), forCellReuseIdentifier: "ModelPortfolioTableViewCell")
                    let cellIdentifier = "ModelPortfolioTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ModelPortfolioTableViewCell
                    section1CellHeight = Double(cell.modelPortfolioXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self
                    
                    if adTitle != ""{
                     cell.ageTextField.text = adTitle
                    }
                    
                    cell.ageTextField.delegate = self
                    
                    if adDescription != ""{
                        cell.weightTextField.text = adTitle
                    }
                    
                    cell.weightTextField.delegate = self
                    
                    
                    if screenSize != ""{
                        cell.hairColorTextField.text = screenSize
                    }
                    cell.hairColorTextField.delegate = self
                    if ram != ""{
                        cell.eyeColorTextField.text = ram
                    }
                    cell.eyeColorTextField.delegate = self
                    
                    if hardDisk != "" {
                        cell.languageKnownTextField.text = hardDisk
                    }
                    cell.languageKnownTextField.delegate = self
                    if processor != ""{
                        cell.locationTextField.text = processor
                    }
                    cell.locationTextField.delegate = self
                    
                    cell.expYearHeaderLabel.isHidden = true
                    cell.expYearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.expYearLabel.isHidden = true
                        cell.expYearHeaderLabel.text = "Experience(Yrs)"
                        cell.expYearHeaderLabel.isHidden = false
                        cell.expYearValueLabel.text = productType
                        cell.expYearValueLabel.isHidden = false
                    }
                    
                    cell.expmonthHeaderLabel.isHidden = true
                    cell.expMonthValueLabel.isHidden = true
                    
                    if type != ""{
                        
                        cell.expmonthLabel.isHidden = true
                        cell.expmonthHeaderLabel.text = "Experience(Mths)"
                        cell.expmonthHeaderLabel.isHidden = false
                        cell.expMonthValueLabel.text = type
                        cell.expMonthValueLabel.isHidden = false
                    }
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    
                    cell.delegate = self
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 112 || subCategory["sub_category_id"].intValue == 113 || subCategory["sub_category_id"].intValue == 114
                {
                     tableView.register(UINib(nibName: "FashionAndCostumeDesignTableViewCell", bundle: nil), forCellReuseIdentifier: "FashionAndCostumeDesignTableViewCell")
                    let cellIdentifier = "FashionAndCostumeDesignTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FashionAndCostumeDesignTableViewCell
                    section1CellHeight = Double(cell.fashionAndCostumeDesignXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    
                    if screenSize != ""{
                        cell.locationTextField.text = screenSize
                    }
                    cell.locationTextField.delegate = self
                    
                    cell.expYearHeaderLabel.isHidden = true
                    cell.expYearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.expYearLabel.isHidden = true
                        cell.expYearHeaderLabel.text = "Experience(Yrs)"
                        cell.expYearHeaderLabel.isHidden = false
                        cell.expYearValueLabel.text = productType
                        cell.expYearValueLabel.isHidden = false
                    }
                    
                    cell.expmonthHeaderLabel.isHidden = true
                    cell.expMonthValueLabel.isHidden = true
                    
                    if type != ""{
                        
                        cell.expmonthLabel.isHidden = true
                        cell.expmonthHeaderLabel.text = "Experience(Mths)"
                        cell.expmonthHeaderLabel.isHidden = false
                        cell.expMonthValueLabel.text = type
                        cell.expMonthValueLabel.isHidden = false
                    }
                    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                    
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else if subCategory["sub_category_id"].intValue == 164
                {
                     tableView.register(UINib(nibName: "OtherBollywoodTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherBollywoodTableViewCell")
                    let cellIdentifier = "OtherBollywoodTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OtherBollywoodTableViewCell
                    section1CellHeight = Double(cell.otherBollywoodXibHeight.constant)
                    cell.enterPriceTextField.iconColor = UIColor.lightGray
                    cell.enterPriceTextField.selectedIconColor = UIColor.green
                    cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
                    cell.enterPriceTextField.iconText = "\u{20B9}"
                    if price != 0{
                        cell.enterPriceTextField.text = "\(price)"
                    }
                    cell.enterPriceTextField.delegate = self

                    if screenSize != ""{
                        cell.locationTextField.text = screenSize
                    }
                    cell.locationTextField.delegate = self
                    
                    cell.brandHeaderLabel.isHidden = true
                    cell.brandValueLabel.isHidden = true
                    
                    if selectedBrand != ""{
                        
                        cell.selectBrandLabel.isHidden = true
                        cell.brandHeaderLabel.text = "Select Type"
                        cell.brandHeaderLabel.isHidden = false
                        cell.brandValueLabel.text = selectedBrand
                        cell.brandValueLabel.isHidden = false
                    }
                    
                    cell.expYearHeaderLabel.isHidden = true
                    cell.expYearValueLabel.isHidden = true
                    
                    if productType != ""{
                        
                        cell.expYearLabel.isHidden = true
                        cell.expYearHeaderLabel.text = "Experience(Yrs)"
                        cell.expYearHeaderLabel.isHidden = false
                        cell.expYearValueLabel.text = productType
                        cell.expYearValueLabel.isHidden = false
                    }
                    
                    cell.expmonthHeaderLabel.isHidden = true
                    cell.expMonthValueLabel.isHidden = true
                    
                    if type != ""{
                        
                        cell.expmonthLabel.isHidden = true
                        cell.expmonthHeaderLabel.text = "Experience(Mths)"
                        cell.expmonthHeaderLabel.isHidden = false
                        cell.expMonthValueLabel.text = type
                        cell.expMonthValueLabel.isHidden = false
                    }
    
                    print(priceAttribute)
                    cell.priceAttributeLabel.isHidden = false
                    if priceAttribute == ""{
                        cell.priceAttributeLabel.isHidden = true
                    }
                    cell.priceAttributeLabel.text = "( " + "\(self.priceAttribute)" +  " )"
                    currentButtonForSellerType = cell.individualButton
                 
                    cell.delegate = self
                    
                    
                    return cell
                    
                }
                else{
                     tableView.register(UINib(nibName: "MobileTableViewCell", bundle: nil), forCellReuseIdentifier: "MobileTableViewCell")
                    let cellIdentifier = "MobileTableViewCell"
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MobileTableViewCell
                    
                    return cell
                 }
            
        }
        
        else{
            
            tableView.register(UINib(nibName: "MobileTableViewCell", bundle: nil), forCellReuseIdentifier: "MobileTableViewCell")
            
            let cellIdentifier = "MobileTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MobileTableViewCell
            section1CellHeight = Double(cell.mobileXibHeight.constant)
            cell.enterPriceTextField.iconColor = UIColor.lightGray
            cell.enterPriceTextField.selectedIconColor = UIColor.green
            cell.enterPriceTextField.iconFont = UIFont(name: "FontAwesome", size: 15)
            cell.enterPriceTextField.iconText = "\u{20B9}"
            
            
            return cell
        }
    
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        if indexPath.section == 0{
            print(CGFloat(section0CellHeight))
          return CGFloat(section0CellHeight)
            
        }
        else{
            print(CGFloat(section1CellHeight))
         return CGFloat(section1CellHeight)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isReachedFromSubCategorySegue{
        return 2
        }else{
          return 1
        }
    }
  
    func selectCategoryButtonDidTapped(cell: PostAdHeaderTableViewCell,sender : AnyObject){
        
        performSegue(withIdentifier: "PostAdToCategory", sender: cell)
        LocalStore.removeObject(key: "MultipleSelection1")
        LocalStore.removeObject(key: "MultipleSelection2")
        
    }
    
    @IBAction func nextButtonDidTapped(_ sender: AnyObject) {
         postDataUsingSubCategoryId()
    }
    
   
    func postDataUsingSubCategoryId(){
        
        subCategoryId = subCategory["sub_category_id"].intValue
        switch (subCategoryId){
            
        case 1:
           var connectivityArray = [String]()
           for (theKey, theValue) in connectivity{
            if theValue == true{
              connectivityArray.append(connectivityButtonArray[theKey])
            }
           }
           
           var accessoriesArray = [String]()
           for (theKey, theValue) in accessories{
            if theValue == true{
                if theKey == 6{
                 accessoriesArray.append(accessoriesButtonArray[0])
                }
                if theKey == 7{
                 accessoriesArray.append(accessoriesButtonArray[1])
                }
                if theKey == 8{
                 accessoriesArray.append(accessoriesButtonArray[2])
                }
                if theKey == 9{
                 accessoriesArray.append(accessoriesButtonArray[3])
                }
            }
           }
           
            categoryId = subCategory["category_id"].intValue
           
          let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": categoryId as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"brand_name":selectedBrand as AnyObject,"condition":condition as AnyObject]
           
          let parameters2 = ["os":operatingSystem as AnyObject,"sim":simSlots as AnyObject,"size":size as AnyObject,"camera":camera as AnyObject,"iandc":connectivityArray as AnyObject,"incl":accessoriesArray as AnyObject]
           
          let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
           
           parameters = parameters1.merged(with: parameters2)
           parameters = parameters.merged(with: parameters3)
          performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
        case 2:
            var connectivityArray = [String]()
            for (theKey, theValue) in connectivity{
                if theValue == true{
                    if theKey == 10{
                        connectivityArray.append(connectivityButtonArray[0])
                    }
                    if theKey == 11{
                        connectivityArray.append(connectivityButtonArray[1])
                    }
                    if theKey == 12{
                        connectivityArray.append(connectivityButtonArray[2])
                    }
                    if theKey == 13{
                        connectivityArray.append(connectivityButtonArray[3])
                    }
                    if theKey == 14{
                        connectivityArray.append(connectivityButtonArray[4])
                    }
                    if theKey == 15{
                        connectivityArray.append(connectivityButtonArray[5])
                    }
                  
                }
            }
            
            var accessoriesArray = [String]()
            for (theKey, theValue) in accessories{
                if theValue == true{
                    if theKey == 16{
                        accessoriesArray.append(accessoriesButtonArray[0])
                    }
                    if theKey == 17{
                        accessoriesArray.append(accessoriesButtonArray[1])
                    }
                    if theKey == 18{
                        accessoriesArray.append(accessoriesButtonArray[2])
                    }
                    if theKey == 19{
                        accessoriesArray.append(accessoriesButtonArray[3])
                    }
                }
            }
            
 
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title": adTitle as AnyObject as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"brand_name":selectedBrand as AnyObject,"condition":condition as AnyObject]
            
            let parameters2 = ["os":operatingSystem as AnyObject,"sim":simSlots as AnyObject,"size":size as AnyObject,"camera":camera as AnyObject,"iandc":connectivityArray as AnyObject,"incl":accessoriesArray as AnyObject]
            
            let parameters3 = ["ram":ram as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 3,21,22,23,24,26,95,96,26:
            
           //some issues type is given in api but missing in view
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect": priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
        
            break
        
        case 4,11:
            
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"make": selectedBrand as AnyObject,"model": "" as AnyObject]
            
            let parameters2 = ["modelInput": "" as AnyObject,"year":"" as AnyObject,"variant":"" as AnyObject,"color":"" as AnyObject,"owner":size as AnyObject,"trans":condition as AnyObject,"fueltype":operatingSystem as AnyObject,"kmd":screenSize as AnyObject,"insurance":simSlots as AnyObject,"reg":camera as AnyObject,"reg_no":"" as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 5,6:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"make": selectedBrand as AnyObject,"year":productType as AnyObject,"kmd":screenSize as AnyObject,"owner":size as AnyObject,"insurance":simSlots as AnyObject,"reg":camera as AnyObject,"reg_no":"" as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 7:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"year":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 8:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"year":productType as AnyObject,"owner":size as AnyObject,"insurance":simSlots as AnyObject,"reg":camera as AnyObject,"reg_no":"" as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 10:
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject]
            
            let parameters2 = ["make": selectedBrand as AnyObject,"year":productType as AnyObject,"noh":screenSize as AnyObject,"trans":condition as AnyObject,"fueltype":operatingSystem as AnyObject,"owner":size as AnyObject,"insurance":simSlots as AnyObject,"reg":camera as AnyObject,"reg_no":"" as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
        
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
          
        case 12:
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject]
            
            let parameters2 = ["type": selectedBrand as AnyObject,"trans":condition as AnyObject,"fueltype":operatingSystem as AnyObject,"year":productType as AnyObject,"owner":size as AnyObject,"insurance":simSlots as AnyObject,"reg":camera as AnyObject,"reg_no":"" as AnyObject,"kmd":screenSize as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
         
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 13,97,98,99,100,101,102,169:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 14:
         //year field is missing in the laptop & computers view
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"type":productType as AnyObject]
            
            let parameters2 = ["condition":condition as AnyObject,"type":productType as AnyObject,"brand_name":selectedBrand as AnyObject,"screen":screenSize as AnyObject,"ram":ram as AnyObject,"hard":hardDisk as AnyObject,"processor":processor as AnyObject,"year":"" as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 15,17,19:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"type": selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
         
        case 16:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"type": productType as AnyObject,"brand": selectedBrand as AnyObject,"screen":screenSize as AnyObject,"year":"" as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 18:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"make":selectedBrand as AnyObject,"type": productType as AnyObject,"mp":megaPixelType as AnyObject,"year":"" as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
            //product type array need to be updated.
        case 20:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type": selectedBrand as AnyObject,"product":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 25:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"type":type as AnyObject,"ton":operatingSystem as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 26:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"type":operatingSystem as AnyObject,"stv":type as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
     
        case 27:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"type":operatingSystem as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
         
        case 28:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"type":type as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        
        case 29:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"capacity":operatingSystem as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
         
        case 30:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"type":operatingSystem as AnyObject,"capacity":camera as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 31:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 32:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"type":operatingSystem as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
    
        case 33,34,35,37,38,39,40:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"type":selectedBrand as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break

        case 36:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"brand_name":selectedBrand as AnyObject,"capacity":operatingSystem as AnyObject,"year":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 41,42,43,103,104,105:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition": condition as AnyObject,"type":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 44:
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"property_type": productType as AnyObject]
            
            let parameters2 = ["area":simSlots as AnyObject,"room":operatingSystem as AnyObject,"balconies":camera as AnyObject,"flrnumber":noOfFloor as AnyObject,"tflrnumber":totalFloor as AnyObject,"security_deposit":securityDeposit as AnyObject,"furnished":size as AnyObject,"car":ram as AnyObject,"flat-amenities":flatAmentiesArray as AnyObject,"society-amenities":societyAmentiesArray as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        
        case 45:
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"property_type": productType as AnyObject,"area":simSlots as AnyObject,"room":operatingSystem as AnyObject,"balconies":camera as AnyObject,"flrnumber":noOfFloor as AnyObject]
            
            let parameters2 = ["tflrnumber":totalFloor as AnyObject,"prtyowner":productType1 as AnyObject,"bathroom":megaPixelType as AnyObject,"furnished":size as AnyObject,"car":ram as AnyObject,"flat-amenities":flatAmentiesArray as AnyObject,"society-amenities":societyAmentiesArray as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 46:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type": camera as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 48,49:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type": selectedBrand as AnyObject,"area":productType as AnyObject,"security_deposit":"" as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
         
            
        case 50:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"room": operatingSystem as AnyObject,"area":size as AnyObject,"bathroom":condition as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        
        case 51:
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"room": camera as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 56,57,58,60,61,62,63:
            
            //featureArray
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"feature":flatAmentiesArray as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no,":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 59,64,65,72,73,74,117,120,121,122,123,124,171:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 66,67,141,143:
            
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"type":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 70,71:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"make":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
            
        case 54,68,170:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"type":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
        case 69,150,151:
            
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 115:
            // salary offered is missing.
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
            
        case 116,118,119,125,134,135,136,137,139,140,145:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,138,142,144,152,153,154,155,156,157:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 75:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type":selectedBrand as AnyObject,"categories":productType as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 52,53,55,76,77:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"type":selectedBrand as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
            break
        case 108,110:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"type":screenSize as AnyObject,"sale":ram as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
                 performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 109:
            //type issue given in api not appear at view.
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"advertised":sellerType as AnyObject]
            
            let parameters2 = ["type":productType as AnyObject,"role":screenSize as AnyObject,"gender":condition as AnyObject,"noposition":ram as AnyObject,"agegroup":hardDisk as AnyObject,"location":processor as AnyObject,"desc":adDescription as AnyObject]
            
            let parameters3 = ["first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 165,166,167,168:
            //type issue given in api not appear at view.
            
            
            
            
            
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"product":"" as AnyObject,"type":selectedBrand as AnyObject,"brand_name":screenSize as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
        case 111:
            //type issue given in api not appear at view.
            
            
            let parameters1 = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"age": adTitle1 as AnyObject]
            
            let parameters2 = ["weight":adDescription1 as AnyObject,"hair":screenSize as AnyObject,"eyecolor":ram as AnyObject,"languagesknown":hardDisk as AnyObject,"yer":productType as AnyObject,"month":type as AnyObject,"location":screenSize as AnyObject]
            
            let parameters3 = ["desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            parameters = parameters1.merged(with: parameters2)
            parameters = parameters.merged(with: parameters3)
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
           
            break
          
        case 112,113,114:
            //type issue given in api not appear at view.
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"advertised":sellerType as AnyObject,"yer":productType as AnyObject,"month":type as AnyObject,"location":screenSize as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            
        
            break
            
        case 164:
            //type issue given in api not appear at view.
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"advertised":sellerType as AnyObject,"type":selectedBrand as AnyObject,"yer":productType as AnyObject,"month":type as AnyObject,"location":screenSize as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 146,147,148,149,173,174,175,176,177,178:
           //type issue given in api not appear at view.
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"product":"" as AnyObject,"type":selectedBrand as AnyObject,"brand_name":screenSize as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 126,127,128,129,130,131,132,133,158,159,160,161,162,163:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"advertised":camera as AnyObject,"type":selectedBrand as AnyObject,"location":screenSize as AnyObject,"timings":ram as AnyObject,"yer":hardDisk as AnyObject,"month":"" as AnyObject,"skills":processor as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        case 172,179:
            
            parameters = ["sub_cat_id": subCategoryId as AnyObject,"category_id": subCategory["category_id"].intValue as AnyObject,"title":adTitle as AnyObject,"priceselect":priceAttribute as AnyObject,"price":price as AnyObject,"you":sellerType as AnyObject,"condition":condition as AnyObject,"desc":adDescription as AnyObject,"first_name":"" as AnyObject,"email":"" as AnyObject,"mobile_no":"" as AnyObject,"state":state as AnyObject,"city":city as AnyObject,"landmark":LocalStore.getCityName as AnyObject,"cmdSubmit":"Submit" as AnyObject]
            
            performSegue(withIdentifier: "PostAdToSubmitAdSegue", sender: self)
            break
            
        default:
            break
        }
    }
}
extension PostAdViewController : MobileViewDelegate,SelectBrandDelegate,NoOfFloorDelegate,TypeDelegate,MultipleSelectionDelegate{


    func conditionTypeSelectedButton(cell: UITableViewCell,sender : AnyObject){
        let designableButton :DesignableButton = sender as! DesignableButton
        if designableButton == currentButtonForConditionType{
            condition = (sender.titleLabel??.text)!
            return
        }
        else{
            currentButtonForConditionType?.backgroundColor = UIColor.white
            currentButtonForConditionType?.titleLabel?.textColor = UIColor.blue
            
            designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            designableButton.setTitleColor(UIColor.white, for: .normal)
            currentButtonForConditionType = sender as? DesignableButton
            condition = (sender.titleLabel??.text)!
            
        }
        
    }
    
    func sellerTypeSelectedButton(cell: UITableViewCell,sender : AnyObject){
        let designableButton :DesignableButton = sender as! DesignableButton
        if designableButton == currentButtonForSellerType{
            sellerType = (designableButton.titleLabel?.text)!
            return
        }
        else{
            currentButtonForSellerType?.backgroundColor = UIColor.white
            currentButtonForSellerType?.titleLabel?.textColor = UIColor.blue
            designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            designableButton.setTitleColor(UIColor.white, for: .normal)
            currentButtonForSellerType = designableButton
            sellerType = (designableButton.titleLabel?.text)!
            
        }
        
    }
    
    func operatingSystemTypeSelectedButton(cell: UITableViewCell,sender : AnyObject){
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForOperatingSystem != nil{
            
            if designableButton == currentButtonForOperatingSystem{
                operatingSystem = (designableButton.titleLabel?.text)!
                
            }
            currentButtonForOperatingSystem?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForOperatingSystem?.backgroundColor = UIColor.white
        currentButtonForOperatingSystem?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForOperatingSystem = designableButton
        operatingSystem = (designableButton.titleLabel?.text)!
        
        
        
    }
    
    func simSlotsTypeSelectedButton(cell: UITableViewCell,sender : AnyObject){
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForSimSlots != nil{
            
            if designableButton == currentButtonForSimSlots{
                simSlots = (designableButton.titleLabel?.text)!
                
            }
            currentButtonForSimSlots?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForSimSlots?.backgroundColor = UIColor.white
        currentButtonForSimSlots?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForSimSlots = designableButton
        simSlots = (designableButton.titleLabel?.text)!
        
        
        
    }
    func sizeTypeSelectedButton(cell: UITableViewCell,sender : AnyObject){
        
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForSize != nil{
            
            if designableButton == currentButtonForSize{
                size = (designableButton.titleLabel?.text)!
            }
            currentButtonForSize?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForSize?.backgroundColor = UIColor.white
        currentButtonForSize?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForSize = designableButton
        size = (designableButton.titleLabel?.text)!
        
        
        
    }
    func cameraTypeSelectedButton(cell: UITableViewCell,sender : AnyObject){
        
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForCamera != nil{
            
            if designableButton == currentButtonForCamera{
                camera = (designableButton.titleLabel?.text)!
            }
            currentButtonForCamera?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForCamera?.backgroundColor = UIColor.white
        currentButtonForCamera?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForCamera = designableButton
        camera = (designableButton.titleLabel?.text)!
        
    }
    
    func connectivityTypeSelectedButtonArray(cell: UITableViewCell,sender : AnyObject){
        
        let designableButton :DesignableButton = sender as! DesignableButton
        if connectivity[designableButton.tag] == true{
            
            designableButton.backgroundColor = UIColor.white
            designableButton.setTitleColor(UIColor.blue, for: .normal)
            connectivity.updateValue(false, forKey: designableButton.tag)
            
            
        }else{
            
            designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            designableButton.setTitleColor(UIColor.white, for: .normal)
            connectivity.updateValue(true, forKey: designableButton.tag)
            
        }
    }
    
    func accessoryTypeSelectedButtonArray(cell: UITableViewCell,sender : AnyObject){
        
        let designableButton :DesignableButton = sender as! DesignableButton
        if accessories[designableButton.tag] == true{
            
            designableButton.backgroundColor = UIColor.white
            designableButton.setTitleColor(UIColor.blue, for: .normal)
            accessories.updateValue(false, forKey: designableButton.tag)
            
            
        }else{
            
            designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            designableButton.setTitleColor(UIColor.white, for: .normal)
            accessories.updateValue(true, forKey: designableButton.tag)
            
        }
    }
    
    func selectBrand(cell: UITableViewCell,sender : AnyObject,brandArray : [String],isSelectBrand : Bool){
        self.brandArray = brandArray
        self.isSelectBrand = isSelectBrand
       performSegue(withIdentifier: "MobileCellToSelectBrand", sender: cell)
      
    }
    
    func featuresMultipleSelection(cell: UITableViewCell,sender : AnyObject,multipleSelectionArray : [String],isMultipleSelection :Bool){
        self.brandArray = multipleSelectionArray
        self.isMultipleSelection = isMultipleSelection
        performSegue(withIdentifier: "PostAdToMultipleColumnView", sender: cell)
        
    }
    
    
    
    func priceAttribute(cell: UITableViewCell,sender : AnyObject){
        
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Fixed Price") {
            self.priceAttribute = "Fixed Price"
            self.reloadCellAtRow(row: 1)
        }
        alertView.addButton("Negotiable") {
            self.priceAttribute = "Negotiable"
            self.reloadCellAtRow(row: 1)

        }
        alertView.addButton("Call For Price") {
            self.priceAttribute = "Call For Price"
            self.reloadCellAtRow(row: 1)

        }
        alertView.showSuccess("Select", subTitle: "")
        
    }
    
  
    
    fileprivate func showAlertAction() {
        let alertController = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
        let fixedPriceAction = UIAlertAction(title: "Fixed Price", style: .default, handler: nil)
        
        alertController.addAction(fixedPriceAction)
        
        let negotiableAction = UIAlertAction(title: "Negotiable Price", style: .default, handler: nil)
        alertController.addAction(negotiableAction)
        
        let callForPriceAction = UIAlertAction(title: "Call For Price", style: .default, handler: nil)
        alertController.addAction(callForPriceAction)
        present(alertController, animated: true, completion: nil)
    }

    func selectedBrand(selectedBrand :String){
        self.selectedBrand = selectedBrand
        print(selectedBrand)
        self.reloadCellAtRow(row: 1)
        
    }
    
    func selectedProductType(productType :String){
        self.productType = productType
        print(productType)
        self.reloadCellAtRow(row: 1)

    }

    func ramTypeSelected(cell: UITableViewCell,sender : AnyObject){
        
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForRam != nil{
            
            if designableButton == currentButtonForRam{
                camera = (designableButton.titleLabel?.text)!
            }
            currentButtonForRam?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForRam?.backgroundColor = UIColor.white
        currentButtonForRam?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForRam = designableButton
        camera = (designableButton.titleLabel?.text)!
        
    }

    

    func productTypeSelectedButton(cell: UITableViewCell, sender: AnyObject) {
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForProductType != nil{
            
            if designableButton == currentButtonForProductType{
                productType = (designableButton.titleLabel?.text)!
                
            }
            currentButtonForProductType?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForProductType?.backgroundColor = UIColor.white
        currentButtonForProductType?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForProductType = designableButton
        if subCategoryId == 45{
         productType1 = (designableButton.titleLabel?.text)!
        }
        else{
         productType = (designableButton.titleLabel?.text)!
        }
        
        
    }
    
    
    func megaPixelTypeSelectedButton(cell: UITableViewCell, sender: AnyObject) {
        let designableButton :DesignableButton = sender as! DesignableButton
        if currentButtonForMegaPixelType != nil{
            
            if designableButton == currentButtonForMegaPixelType{
                megaPixelType = (designableButton.titleLabel?.text)!
                
            }
            currentButtonForMegaPixelType?.backgroundColor = UIColor.white
            
        }
        
        currentButtonForMegaPixelType?.backgroundColor = UIColor.white
        currentButtonForMegaPixelType?.titleLabel?.textColor = UIColor.blue
        designableButton.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 131.0/255.0, blue: 108.0/255.0, alpha: 1.0)
        designableButton.setTitleColor(UIColor.white, for: .normal)
        currentButtonForMegaPixelType = designableButton
        megaPixelType = (designableButton.titleLabel?.text)!
        
    }
    
    
    func selectFloorNumber(cell: UITableViewCell, sender: AnyObject,floorArray  : [String],isTotalFloor : Bool) {
        self.floorArray = floorArray
        self.isTotalFloor = isTotalFloor
        performSegue(withIdentifier: "NoOfFloorSegue", sender: cell)
     
    }
    
   
    func type(cell: UITableViewCell, sender: AnyObject,typeArray : [String], isType  : Bool) {
        self.typeArray = typeArray
        self.isType = isType
        performSegue(withIdentifier: "PostAdToSelectTypeSegue", sender: cell)
        
    }

    func selectedNoOfFloor(noOfFloor :String){
        self.noOfFloor = noOfFloor
        print(noOfFloor)
        self.reloadCellAtRow(row: 1)

    }
    
    func selectedTotalFloor(totalFloor  :String){
        self.totalFloor = totalFloor
        print(totalFloor)
        self.reloadCellAtRow(row: 1)

    }
    
    func selectedType(type :String){
        self.type = type
        print(type)
        self.reloadCellAtRow(row: 1)

    }
    
    func multipleSelection1(selectedItemsArray:[String]){
       self.flatAmentiesArray = selectedItemsArray
       self.reloadCellAtRow(row: 1)
 
    }
    
    func multipleSelection2(selectedItemsArray:[String]){
     self.societyAmentiesArray = selectedItemsArray
     self.reloadCellAtRow(row: 1)
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MobileCellToSelectBrand"{
            let destinationVc = segue.destination as! SelectBrandViewController
            destinationVc.brandArray = self.brandArray
            destinationVc.isSelectBrand = isSelectBrand
            destinationVc.delegate = self
        
        }
        
        if segue.identifier == "NoOfFloorSegue"{
            let destinationVc = segue.destination as! NoOfFloorViewController
            destinationVc.floorArray = self.floorArray
            destinationVc.isTotalFloor = isTotalFloor
            destinationVc.delegate = self
            
        }
       
        if segue.identifier == "PostAdToSelectTypeSegue"{
            let destinationVc = segue.destination as! SelectTypeViewController
            destinationVc.typeArray = self.typeArray
            destinationVc.isType = isType
            destinationVc.delegate = self
            
        }
        if segue.identifier == "PostAdToSubmitAdSegue"{
            let destinationVc = segue.destination as! SubmitAdViewController
            destinationVc.parameters = self.parameters
        }
        if segue.identifier == "PostAdToMultipleColumnView"{
            let destinationVc = segue.destination as! MultipleColumnSelectedViewController
            destinationVc.itemsArray = self.brandArray
            destinationVc.ismultipleSelection = isMultipleSelection
            destinationVc.delegate = self
        }
        
        
    }
    
    
    private func reloadCellAtRow(row: Int) {
        tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: .none)
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
