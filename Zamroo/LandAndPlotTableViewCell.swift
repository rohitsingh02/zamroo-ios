//
//  LandAndPlotTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LandAndPlotTableViewCell: UITableViewCell {

    
   
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var enterPriceEditText: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var landAndPlotXibHeight: NSLayoutConstraint!
    
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
    
    
    @IBAction func typeButtonTapped(_ sender: AnyObject) {
        
         delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
    }
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
