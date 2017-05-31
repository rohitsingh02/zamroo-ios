//
//  MensClothingTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import  SkyFloatingLabelTextField

class MensClothingTableViewCell: UITableViewCell {

    @IBOutlet var mensClothingXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var priceAttributeLabel: UILabel!


    
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
        if LocalStore.getSubCategoryId() == 103 || LocalStore.getSubCategoryId() == 104 || LocalStore.getSubCategoryId() == 105{
           delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.mensClothingTypeArray,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 41{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.booksTypeArray,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 42{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.cdTypeArray,isSelectBrand: true )
        }
        else  if LocalStore.getSubCategoryId() == 43{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.stationaryTypeArray,isSelectBrand: true )
        }
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
