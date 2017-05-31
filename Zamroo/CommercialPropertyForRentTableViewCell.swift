//
//  CommercialPropertyForRentTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CommercialPropertyForRentTableViewCell: UITableViewCell {

    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectAreaTypeLabel: UILabel!
    @IBOutlet var areaTypeValueLabel: UILabel!
    @IBOutlet var areaTypeHeaderLabel: UILabel!
    
    @IBOutlet var selectPropertyTypeLabel: UILabel!
    @IBOutlet var propertyTypeValueLabel: UILabel!
    @IBOutlet var propertyTypeHeaderLabel: UILabel!
    
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    @IBOutlet var usedButton: DesignableButton!
    
    @IBOutlet var commercialPropertyForRentXibHeight: NSLayoutConstraint!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func conditionTypeButton(_ sender: AnyObject) {
        
        delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
    @IBAction func propertyTypeButtonTapped(_ sender: AnyObject) {
        
        if LocalStore.getSubCategoryId() == 48{
          delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.commercialPropertyForRentPropertyTypeArray,isSelectBrand: true )
        
        }
        else if LocalStore.getSubCategoryId() == 49{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.commercialPropertyForRentPropertyTypeArray,isSelectBrand: true )
            
        }
       
    }
  
    
    @IBAction func areaInSqftTapped(_ sender: AnyObject) {
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.areaInSqFtArray,isSelectBrand: false )
        
        
    }
 
}
