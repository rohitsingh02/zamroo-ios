//
//  GamingAndConsolesTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class GamingAndConsolesTableViewCell: UITableViewCell {

    @IBOutlet var gamingAndConsoleXibHeight: NSLayoutConstraint!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var selectProductTypeLabel: UILabel!
    @IBOutlet var productTypeValueLabel: UILabel!
    @IBOutlet var productTypeHeaderLabel: UILabel!
    
    
    
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
    
    @IBAction func productTapped(_ sender: DesignableButton) {
        
        delegate?.productTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    @IBAction func productTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.gamingAndConsoleProductTypeArray, isSelectBrand : true)
    }
    
}
