//
//  HomeTutorsTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class HomeTutorsTableViewCell: UITableViewCell {

    @IBOutlet var homeTutorsXibHeight: NSLayoutConstraint!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    weak var delegate:MobileViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectTypeButtonTapped(_ sender: AnyObject) {
        
         if LocalStore.getSubCategoryId() == 66{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.homeTutorType,isSelectBrand: true )
        }
         else  if LocalStore.getSubCategoryId() == 67{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.onlineTutorType,isSelectBrand: true )
        }
         else  if LocalStore.getSubCategoryId() == 141{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.childSafetyProductType,isSelectBrand: true )
        }
         else  if LocalStore.getSubCategoryId() == 143{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.babyFeedingtype,isSelectBrand: true )
        }
     
    }
    
    @IBAction func priceAttributeButtonTapped(_ sender: AnyObject) {
        
        delegate?.priceAttribute(cell: self, sender: sender)
        
    }
    
}
