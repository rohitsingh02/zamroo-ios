//
//  ActingSchoolTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 20/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ActingSchoolTableViewCell: UITableViewCell {

    @IBOutlet var priceAttributeLabel: UILabel!

    
    @IBOutlet var actingSchoolXibHeight: NSLayoutConstraint!
    @IBOutlet var locationTextField: SkyFloatingLabelTextField!
    @IBOutlet var enterPriceTextField: SkyFloatingLabelTextFieldWithIcon!
    weak var delegate:MobileViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func priceAttributeTapped(_ sender: AnyObject) {
        delegate?.priceAttribute(cell: self, sender : sender)
    }
    
    
}
