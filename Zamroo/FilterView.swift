//
//  FilterView.swift
//  Zamroo
//
//  Created by Rohit Singh on 01/10/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol FilterViewDelegate:class {
    
    func filterButtonTapped()
    func sortButtonTapped()
    
}



class FilterView: UITableViewHeaderFooterView {

    weak var delegate:FilterViewDelegate?
    

    @IBAction func filterButtonAction(_ sender: Any) {
        
         delegate?.filterButtonTapped()
        
    }

    @IBAction func sortButtonAction(_ sender: Any) {
        
        delegate?.sortButtonTapped()
    }

    
}
