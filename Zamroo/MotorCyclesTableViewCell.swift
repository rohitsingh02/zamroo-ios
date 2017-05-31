//
//  MotorCyclesTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class MotorCyclesTableViewCell: UITableViewCell {

    
    @IBOutlet var motorCycleXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    
    @IBOutlet var selectModelYearLabel: UILabel!
    @IBOutlet var ModelYearValueLabel: UILabel!
    @IBOutlet var ModelYearHeaderLabel: UILabel!
    
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    weak var delegate:MobileViewDelegate?
    
    @IBOutlet var individualButton: DesignableButton!
    
    @IBOutlet var kmsDrivenTextField: SkyFloatingLabelTextField!
    
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
        
        if LocalStore.getSubCategoryId() == 5{
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.motorcycleMakeArray,isSelectBrand: true )
        }
        else if LocalStore.getSubCategoryId() == 6{
         delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.scooterMakeArray,isSelectBrand: true )
        }
    }
    
    @IBAction func selectModelYearButtonTapped(_ sender: AnyObject) {
        
        delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.motorcycleYearArray,isSelectBrand: false )
    }
    
    
    
}