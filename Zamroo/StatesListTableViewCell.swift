//
//  StatesListTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 31/08/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

class StatesListTableViewCell: UITableViewCell {

    @IBOutlet var stateTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
