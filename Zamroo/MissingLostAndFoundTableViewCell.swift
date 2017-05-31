//
//  MissingLostAndFoundTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class MissingLostAndFoundTableViewCell: UITableViewCell {

    @IBOutlet var missingLostAndFoundXibHeight: NSLayoutConstraint!
    weak var delegate:MobileViewDelegate?
    
   
    
    @IBOutlet var selectBrandLabel: UILabel!
    @IBOutlet var brandValueLabel: UILabel!
    @IBOutlet var brandHeaderLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectTypeButtonTapped(_ sender: AnyObject) {
        
        if LocalStore.getSubCategoryId() == 68{
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.coachingSchoolType,isSelectBrand: true )
        }
        else {
            delegate?.selectBrand(cell: self, sender: sender,brandArray: AppService.petsTypeArray,isSelectBrand: true )
        }
       
    }
    
    
    
    
}
