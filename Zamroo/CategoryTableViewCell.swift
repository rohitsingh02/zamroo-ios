//
//  CategoryTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 01/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet var categoryIcon: UIImageView!
    
    @IBOutlet var categoryNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
