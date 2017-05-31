//
//  CarsTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CarsTableViewCell: UITableViewCell {

    @IBOutlet var carXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    @IBOutlet var kmsDrivenTextField: SkyFloatingLabelTextField!
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
    
    
    @IBAction func transmissionTypeButton(_ sender: AnyObject) {
        
        delegate?.conditionTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func sellerTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.sellerTypeSelectedButton(cell: self, sender: sender)
    }
    
    @IBAction func fuelTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.operatingSystemTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func ownerTypeButtonTapped(_ sender: DesignableButton) {
        delegate?.sizeTypeSelectedButton(cell: self, sender: sender)
        
    }
    
    
    @IBAction func insuranceTypeButtonTapped(_ sender: DesignableButton) {
        delegate?.simSlotsTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func registrationTypeButtonTapped(_ sender: DesignableButton) {
        
        delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
    
    @IBAction func selectMakeButtonTapped(_ sender: AnyObject) {
        
        if LocalStore.getSubCategoryId() == 4{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.carMakeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 11{
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.suvMakeArray,isSelectBrand: true )
        
        }
        
     
    }
    
   
    
}
