//
//  TabletTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class TabletTableViewCell: UITableViewCell {

    @IBOutlet var tabletXibHeight: NSLayoutConstraint!
    @IBOutlet var individualButton: DesignableButton!
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var usedButton: DesignableButton!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    weak var delegate:MobileViewDelegate?
    
    
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
    
    
    @IBAction func operatingSystemSelectedButton(_ sender: DesignableButton) {
        
        delegate?.operatingSystemTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func sizeTypeButtonTapped(_ sender: DesignableButton) {
        delegate?.sizeTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func simSlotsTypeButtonTapped(_ sender: DesignableButton) {
        delegate?.simSlotsTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func cameraTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func ramTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.ramTypeSelected(cell: self, sender: sender)
    }
    
    @IBAction func connectivityTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.connectivityTypeSelectedButtonArray(cell: self, sender: sender)
    }
    
    
    @IBAction func accessoriesTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.accessoryTypeSelectedButtonArray(cell: self, sender: sender)
    }
    
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
       delegate?.priceAttribute(cell: self, sender: sender)
       
        
    }
    
    
    @IBAction func selectBrandButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.tabletBrandArray,isSelectBrand: true)
    }
    
    
    
}
