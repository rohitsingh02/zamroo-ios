//
//  ShareListingTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 03/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol ShareListingTableViewCellDelegate:class {
    
    func facebookShareButton(cell:UITableViewCell,sender: AnyObject)
    func  twitterShareButtonTapped(cell:UITableViewCell,sender: AnyObject)
    func googleShareButton(cell:UITableViewCell,sender: AnyObject)
    func whattsShareButton(cell:UITableViewCell,sender: AnyObject)
    func reportAdButton(cell:UITableViewCell,sender: AnyObject)

    
}


class ShareListingTableViewCell: UITableViewCell {

    weak var delegate:ShareListingTableViewCellDelegate?
    
    
    @IBOutlet var userProfileImage: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    
    @IBOutlet var AdIdLabel: UILabel!
    
    
    @IBOutlet var reportAdButton: UIButton!
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func facebookShareButtonClicked(_ sender: AnyObject) {
        delegate?.facebookShareButton(cell: self, sender: sender)
    }
    
    
    @IBAction func twitterShareButton(_ sender: AnyObject) {
        delegate?.twitterShareButtonTapped(cell: self, sender: sender)
    }
    
    @IBAction func googleShareButtonTapped(_ sender: AnyObject) {
        delegate?.googleShareButton(cell: self, sender: sender)
    }
    
    @IBAction func whattsShareButtonTapped(_ sender: AnyObject) {
        
        delegate?.whattsShareButton(cell: self, sender: sender)
    }
    
    @IBAction func reportAdButtonTapped(_ sender: Any) {
        
        delegate?.reportAdButton(cell: self, sender: sender as AnyObject)
        
    }
    
    
}
