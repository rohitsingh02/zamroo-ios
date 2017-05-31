//
//  AuditionAndCastingTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AuditionAndCastingTableViewCell: UITableViewCell {
    @IBOutlet var individualButton: DesignableButton!
    weak var delegate:MobileViewDelegate?

    @IBOutlet var auditionAndCastingXibHeight: NSLayoutConstraint!
    @IBOutlet var locationTextField: SkyFloatingLabelTextField!
    @IBOutlet var ageGroupTextField: SkyFloatingLabelTextField!
    @IBOutlet var noOfPositionTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var priceAttributeLabel: UILabel!


    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    @IBOutlet var roleTextField: SkyFloatingLabelTextField!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func genderTypeButton(_ sender: AnyObject) {
        
        delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func selectTypeTapped(_ sender: AnyObject) {
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.auditionType,isSelectBrand: true )
        
    }
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
