//
//  SafetyTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 03/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol SafetyDelegate:class {
    
    func moreButton(cell:UITableViewCell,sender: AnyObject)
}

class SafetyTableViewCell: UITableViewCell {

    @IBOutlet var safetyLabel: UILabel!
    
    @IBOutlet var safetyLine1: UILabel!
    
     weak var delegate:SafetyDelegate?
    
    
    @IBOutlet var safetyLine2: UILabel!
    
    @IBOutlet var safetyLine3: UILabel!
    
    @IBOutlet var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func moreButtonTapped(_ sender: Any) {
        
       delegate?.moreButton(cell: self, sender: sender as AnyObject)
        
    }
    

}
