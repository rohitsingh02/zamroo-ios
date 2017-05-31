//
//  AccessoriesTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AccessoriesTableViewCell: UITableViewCell {

    @IBOutlet var accessoriesXibHeight: NSLayoutConstraint!

    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    @IBOutlet var usedButton: DesignableButton!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    
    @IBOutlet var priceAttributeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
  
    }
    
    
    
    @IBAction func accessoriesConditionButtonTapped(_ sender: AnyObject) {
         delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func accessoriesSellerTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
}
