//
//  HomeImprovementAndRepairTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class HomeImprovementAndRepairTableViewCell: UITableViewCell {

    @IBOutlet var homeImprovementAndRepairXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func selectTypeButtonTapped(_ sender: AnyObject) {
        
        if LocalStore.getSubCategoryId() == 116{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.homeRepairTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 118{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.telecomRepairTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 119{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.healthAndBeautyTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 125{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.personalFinanceTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 145{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.otherServicesTypeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 134{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.babyClothingType,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 135{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.babyClothingType,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 136{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.toyType,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 137{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.toyType,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 139{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.mobileBrandArray,isSelectBrand: true )
            //ui not working
        }
        else if LocalStore.getSubCategoryId() == 140{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.babyBathTypesArray,isSelectBrand: true )
        }
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
}
