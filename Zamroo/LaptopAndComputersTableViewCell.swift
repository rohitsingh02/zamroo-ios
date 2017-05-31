//
//  LaptopAndComputersTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class LaptopAndComputersTableViewCell: UITableViewCell {

    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var laptopAndComputerXibHeight: NSLayoutConstraint!
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    @IBOutlet var screenSizeTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var ramTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var hardDiskTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var processorTextField: SkyFloatingLabelTextField!
    
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
    
    
    @IBAction func laptopConditionButtonTapped(_ sender: AnyObject) {
        delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    @IBAction func laptopSellerTypeButtonTapped(_ sender: AnyObject) {
        
          delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
  
    @IBAction func laptopProductTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.productTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func laptopSelectBrandButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.laptopBrandArray,isSelectBrand : true)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
