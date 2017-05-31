//
//  JewelleryTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class JewelleryTableViewCell: UITableViewCell {

    
    @IBOutlet var jewelleryXibHeight: NSLayoutConstraint!
    @IBOutlet var individualButton: DesignableButton!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var selectTypeLabel: UILabel!
    @IBOutlet var typeValueLabel: UILabel!
    @IBOutlet var typeHeaderLabel: UILabel!
    
    @IBOutlet var selectSubTypeLabel: UILabel!
    @IBOutlet var subTypeValueLabel: UILabel!
    @IBOutlet var subTypeHeaderLabel: UILabel!
    
    
    
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
    
    @IBAction func selectTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.jewelleryTypeArray,isSelectBrand: true )
    }
    
    @IBAction func selectSubTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.jewellerySubTypeArray,isSelectBrand: false )
    }
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
}
