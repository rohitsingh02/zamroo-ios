//
//  SubCategoryDetailTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 07/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class SubCategoryDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var adImage: UIImageView!
    
    @IBOutlet var adTitle: UILabel!
    
    
    @IBOutlet var locationIconImageView: UIImageView!
    
    @IBOutlet var adLocation: UILabel!

    @IBOutlet var timeDurationLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
