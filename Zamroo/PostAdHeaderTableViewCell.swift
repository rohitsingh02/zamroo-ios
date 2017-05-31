//
//  PostAdHeaderTableViewCell.swift
//  Zamroo
//
//  Created by Rohit Singh on 19/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol SelectCategoryDelegate:class {
    func selectCategoryButtonDidTapped(cell:PostAdHeaderTableViewCell,sender: AnyObject)
}


class PostAdHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet var addPhotoView: UIView!
    
    @IBOutlet var adTitleTextField: UITextField!
    
    @IBOutlet var categoryValueLabel: UILabel!
    @IBOutlet var cellXibHeight: NSLayoutConstraint!
    
    @IBOutlet var selectCategoryLabel: UILabel!
    weak var delegate:SelectCategoryDelegate?
    
    @IBOutlet var adDescriptionTextField: UITextField!
    
    @IBOutlet var categoryHeaderLabel: UILabel!
    

    @IBAction func selectCategoryButtonTapped(_ sender: AnyObject) {
        
       print("Helloooo--------------------------")
     delegate?.selectCategoryButtonDidTapped(cell: self,sender : sender)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
  
}
