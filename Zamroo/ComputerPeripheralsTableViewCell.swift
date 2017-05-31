//
//  ComputerPeripheralsTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ComputerPeripheralsTableViewCell: UITableViewCell {

    @IBOutlet var computerPeripheralsXibHeight: NSLayoutConstraint!
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
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

        // Configure the view for the selected state
    }
    
    
    @IBAction func conditionButtonTapped(_ sender: AnyObject) {
         delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func sellerTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    

    @IBAction func selectBrandButtonTapped(_ sender: AnyObject) {
        
        
        if LocalStore.getSubCategoryId() == 15 {
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.computerPeripheralsProductTypeArray,isSelectBrand : true)
        }
        else if LocalStore.getSubCategoryId() == 17{
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.audioVideoProductTypeArray,isSelectBrand : true)
        }
        else if LocalStore.getSubCategoryId() == 19{
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.cameraAccessoriesProductTypeArray,isSelectBrand : true)
        }
        
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
}
