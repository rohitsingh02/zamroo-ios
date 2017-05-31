//
//  HotelTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class HotelTableViewCell: UITableViewCell {

    @IBOutlet var hotelXibHeight: NSLayoutConstraint!
    @IBOutlet var individualButton: DesignableButton!
    @IBOutlet var priceAttributeLabel: UILabel!

  
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    weak var delegate:MobileViewDelegate?
    
    
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
    
   
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    @IBAction func featureButtonTapped(_ sender: AnyObject) {
        delegate?.featuresMultipleSelection(cell: self, sender: sender,multipleSelectionArray : AppService.hotelFeaturesArray,isMultipleSelection :true)
        
    }
    
}
