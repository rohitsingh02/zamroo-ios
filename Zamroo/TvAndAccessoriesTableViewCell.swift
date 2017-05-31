//
//  TvAndAccessoriesTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TvAndAccessoriesTableViewCell: UITableViewCell {

    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    @IBOutlet var screenSizeTextField: SkyFloatingLabelTextField!
    @IBOutlet var selectProductTypeLabel: UILabel!
    @IBOutlet var productTypeValueLabel: UILabel!
    @IBOutlet var productTypeHeaderLabel: UILabel!
    
    @IBOutlet var tvAndAccessoriesXibHeight: NSLayoutConstraint!
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
    
    
    @IBAction func selectBrandTapped(_ sender: AnyObject) {
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.tvBrandArray,isSelectBrand : true)
    }
    
    @IBAction func productTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.tvProductTypeArray, isSelectBrand : false)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
