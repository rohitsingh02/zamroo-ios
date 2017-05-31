//
//  MultipleSelectionTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 19/10/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class MultipleSelectionTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
