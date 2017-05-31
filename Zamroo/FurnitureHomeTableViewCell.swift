//
//  FurnitureHomeTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FurnitureHomeTableViewCell: UITableViewCell {

    @IBOutlet var furnitureHomeXibHeight: NSLayoutConstraint!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var selectYearLabel: UILabel!
    @IBOutlet var yearValueLabel: UILabel!
    @IBOutlet var yearHeaderLabel: UILabel!
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    @IBOutlet var usedButton: DesignableButton!
    
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
    
    @IBAction func selectTypeButtonTapped(_ sender: AnyObject) {
        
        if LocalStore.getSubCategoryId() == 33{
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.furnitureHomeTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 34{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.homeApplianceTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 35{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.homeDecorativeTypeArray,isSelectBrand: true )
        } else if LocalStore.getSubCategoryId() == 37{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.bathroomRepairTypeArray,isSelectBrand: true )
        } else if LocalStore.getSubCategoryId() == 38{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.hotelAndRestrauntSupplyTypeArray,isSelectBrand: true )
        } else if LocalStore.getSubCategoryId() == 39{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.outdoorGardenItemsTypeArray,isSelectBrand: true )
        } else if LocalStore.getSubCategoryId() == 40{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.otherHouseholdGoodsTypeArray,isSelectBrand: true )
        }
        
    }
    @IBAction func selectYearButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.mobileBrandArray,isSelectBrand: false )
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
