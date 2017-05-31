//
//  AgriculturalTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AgriculturalTableViewCell: UITableViewCell {

    
    @IBOutlet var agriculturalXibHeight: NSLayoutConstraint!

    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    @IBOutlet var brandTextField: SkyFloatingLabelTextField!
    
    
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
    
    @IBAction func selectTypeTapped(_ sender: AnyObject) {
        if LocalStore.getSubCategoryId() == 178{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.agricultureType,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 146{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.healthAndLifeScienceTypes,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 147{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.metalWorkingTypes,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 148{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.mROType,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 176{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.heavyEquipmentsType,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 175{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.automotivetypes,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 174{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.constructiontype,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 149{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.electricalEquipmentType,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 173{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.fuelAndEnergyType,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 177{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.restaurantCateringTypes,isSelectBrand: true )
        }
    }
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
