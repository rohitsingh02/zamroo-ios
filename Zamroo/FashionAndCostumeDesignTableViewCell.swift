//
//  FashionAndCostumeDesignTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FashionAndCostumeDesignTableViewCell: UITableViewCell {

    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var fashionAndCostumeDesignXibHeight: NSLayoutConstraint!
    @IBOutlet var individualButton: DesignableButton!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var expYearLabel: UILabel!
    @IBOutlet var expYearValueLabel: UILabel!
    @IBOutlet var expYearHeaderLabel: UILabel!
    
    
    @IBOutlet var expmonthLabel: UILabel!
    @IBOutlet var expMonthValueLabel: UILabel!
    @IBOutlet var expmonthHeaderLabel: UILabel!
    
    
    
    @IBOutlet var locationTextField: SkyFloatingLabelTextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func advertisedByButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func experienceInYearButtonTapped(_ sender: AnyObject) {
        delegate?.selectBrand(cell:self,sender: sender,brandArray : AppService.experienceYearsType,isSelectBrand : false)
        
    }
    
    @IBAction func experienceInMonthsButtonTapped(_ sender: AnyObject) {
        delegate?.type(cell:self,sender: sender,typeArray : AppService.experienceMonthsType,isType : true)
    }
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
    
}
