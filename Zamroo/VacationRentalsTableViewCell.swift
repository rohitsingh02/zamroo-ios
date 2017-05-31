//
//  VacationRentalsTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class VacationRentalsTableViewCell: UITableViewCell {

    @IBOutlet var vacationRentalsXibHeight: NSLayoutConstraint!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func noOfRoomsTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
