//
//  CameraTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class CameraTableViewCell: UITableViewCell {

    @IBOutlet var cameraXibHeight: NSLayoutConstraint!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectMakeLabel: UILabel!
    @IBOutlet var makeValueLabel: UILabel!
    @IBOutlet var makeHeaderLabel: UILabel!
    
    @IBOutlet var selectProductTypeLabel: UILabel!
    @IBOutlet var productTypeValueLabel: UILabel!
    @IBOutlet var productTypeHeaderLabel: UILabel!
    
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    @IBOutlet var usedButton: DesignableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func conditionTypeButton(_ sender: AnyObject) {
        
        delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func selectMakeTapped(_ sender: AnyObject) {
        delegate?.selectBrand(cell: self, sender: sender, brandArray: AppService.cameraMakeArray, isSelectBrand: true)
    }
    
    @IBAction func productTypeButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.cameraProductTypeArray, isSelectBrand : false)
    }
    
    
    @IBAction func megaPixelTypeSelected(_ sender: AnyObject) {
        
         delegate?.megaPixelTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
}
