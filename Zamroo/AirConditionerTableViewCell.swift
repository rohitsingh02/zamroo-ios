//
//  AirConditionerTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AirConditionerTableViewCell: UITableViewCell {

    @IBOutlet var airConditionerXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectTypeLabel: UILabel!
    @IBOutlet var typeValueLabel: UILabel!
    @IBOutlet var typeHeaderLabel: UILabel!
    
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
    
    
    @IBAction func tonButtonTapped(_ sender: DesignableButton) {
        
        delegate?.operatingSystemTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    @IBAction func selectBrandButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.acBrandArray,isSelectBrand: true )
    }
    
    @IBAction func selectTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.type(cell: self, sender: sender,typeArray: AppService.acSelectTypeArray,isType: true )
    }
    
    @IBAction func selectYearButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.motorcycleYearArray,isSelectBrand: false )
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}