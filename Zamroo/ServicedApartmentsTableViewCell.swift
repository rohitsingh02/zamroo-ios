//
//  ServicedApartmentsTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ServicedApartmentsTableViewCell: UITableViewCell {

    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var servicedApartmentsXibHeight: NSLayoutConstraint!
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    
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
    
  
    @IBAction func bathroomButtonSelected(_ sender: AnyObject) {
      delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    @IBAction func noOfRoomTypeSelected(_ sender: DesignableButton) {
        
      delegate?.operatingSystemTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func areaTypeSelected(_ sender: AnyObject) {
        
        delegate?.sizeTypeSelectedButton(cell:self,sender: sender)
        
    }
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
