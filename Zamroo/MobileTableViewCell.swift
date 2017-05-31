//
//  MobileTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 19/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


protocol MobileViewDelegate:class {
   
    func conditionTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    func sellerTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    func operatingSystemTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    func sizeTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    func simSlotsTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    func cameraTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    func connectivityTypeSelectedButtonArray(cell:UITableViewCell,sender: AnyObject)
    func accessoryTypeSelectedButtonArray(cell:UITableViewCell,sender: AnyObject)
    
    func priceAttribute(cell:UITableViewCell,sender: AnyObject)
    func selectBrand(cell:UITableViewCell,sender: AnyObject,brandArray : [String],isSelectBrand : Bool)
   func ramTypeSelected(cell:UITableViewCell,sender: AnyObject)//tablet
    
    func productTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
    
    
   func megaPixelTypeSelectedButton(cell:UITableViewCell,sender: AnyObject)
   
    
    func selectFloorNumber(cell:UITableViewCell,sender: AnyObject,floorArray : [String],isTotalFloor : Bool)
    

    func type(cell:UITableViewCell,sender: AnyObject,typeArray : [String],isType :Bool)
    
    func featuresMultipleSelection(cell:UITableViewCell,sender: AnyObject,multipleSelectionArray : [String],isMultipleSelection :Bool)
    
}


class MobileTableViewCell: UITableViewCell {

    @IBOutlet var brandHeaderLabel: UILabel!
    @IBOutlet var mobileXibHeight: NSLayoutConstraint!
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    @IBOutlet var usedButton: DesignableButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    @IBAction func conditionTypeButton(_ sender: AnyObject) {
        
        delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
    }

    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
       delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func operatingSystemTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.operatingSystemTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func sizeTypeButtonTapped(_ sender: DesignableButton) {
        delegate?.sizeTypeSelectedButton(cell: self, sender: sender)
       
    }
    
    
    @IBAction func simSlotsTypeButtonTapped(_ sender: DesignableButton) {
       delegate?.simSlotsTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func cameraTypeButtonTapped(_ sender: DesignableButton) {
       
        delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func connectivityTypeButtonTapped(_ sender: DesignableButton) {
       
        delegate?.connectivityTypeSelectedButtonArray(cell: self, sender: sender)
    }
    
    
    @IBAction func accessoriesTypeButtonTapped(_ sender: DesignableButton) {
        
    delegate?.accessoryTypeSelectedButtonArray(cell: self, sender: sender)
    }
    
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
      delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
    @IBAction func selectBrandButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.mobileBrandArray,isSelectBrand: true )
    }
    
}
