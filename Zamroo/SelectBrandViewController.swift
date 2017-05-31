//
//  SelectBrandViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 17/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol SelectBrandDelegate:class {
    
    func selectedBrand(selectedBrand:String)
    func selectedProductType(productType : String)
}


class SelectBrandViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var brandArray = [String]()
    var isSelectBrand = false
    weak var delegate:SelectBrandDelegate?

    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell( withIdentifier:"CellIdentifier",for : indexPath)
       
        cell.textLabel?.text = brandArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isSelectBrand{
            let selectedBrand = brandArray[indexPath.row]
            delegate?.selectedBrand(selectedBrand: selectedBrand)
            dismiss(animated: true, completion: nil)
        }
        else{
            let productType = brandArray[indexPath.row]
            delegate?.selectedProductType(productType: productType)
            dismiss(animated: true, completion: nil)
        }
      
        
    }
    
    
}
