//
//  ProductDescriptionTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 03/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {

    
    @IBOutlet var productDescriptionValueLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
