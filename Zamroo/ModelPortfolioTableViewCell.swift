//
//  ModelPortfolioTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class ModelPortfolioTableViewCell: UITableViewCell {

    @IBOutlet var modelPortfolioXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    @IBOutlet var languageKnownTextField: SkyFloatingLabelTextField!
    @IBOutlet var eyeColorTextField: SkyFloatingLabelTextField!
    @IBOutlet var hairColorTextField: SkyFloatingLabelTextField!
    @IBOutlet var ageTextField: SkyFloatingLabelTextField!
    
    @IBOutlet var weightTextField: SkyFloatingLabelTextField!
    
    
    
    @IBOutlet var expYearLabel: UILabel!
    @IBOutlet var expYearValueLabel: UILabel!
    @IBOutlet var expYearHeaderLabel: UILabel!
    
    
    @IBOutlet var expmonthLabel: UILabel!
    @IBOutlet var expMonthValueLabel: UILabel!
    @IBOutlet var expmonthHeaderLabel: UILabel!
    
    
    
    
    weak var delegate:MobileViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var locationTextField: SkyFloatingLabelTextField!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func experienceInYearButtonTapped(_ sender: AnyObject) {
        delegate?.selectBrand(cell:self,sender: sender,brandArray : AppService.experienceYearsType,isSelectBrand : false)
        
    }
    
    @IBAction func experienceInMonthsButtonTapped(_ sender: AnyObject) {
        delegate?.type(cell:self,sender: sender,typeArray : AppService.experienceMonthsType,isType : true)
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
