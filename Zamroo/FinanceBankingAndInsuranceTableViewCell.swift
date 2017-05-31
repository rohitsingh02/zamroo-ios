//
//  FinanceBankingAndInsuranceTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FinanceBankingAndInsuranceTableViewCell: UITableViewCell {

    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    @IBOutlet var financeBankingAndInsuranceXibHeight: NSLayoutConstraint!
    
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    weak var delegate:MobileViewDelegate?

    
    @IBOutlet var skillsTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var experienceTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var timingTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var locationTextField: SkyFloatingLabelTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func advertiseByButtonTapped(_ sender: DesignableButton) {
   
        delegate?.cameraTypeSelectedButton(cell: self, sender: sender)
    }
    
    
    @IBAction func typeOfJobButtonTapped(_ sender: AnyObject) {
    
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.otherJobsTypeOfJobsArray,isSelectBrand: true )
        
        
    
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
