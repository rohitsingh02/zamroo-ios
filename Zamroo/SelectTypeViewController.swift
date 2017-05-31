//
//  SelectTypeViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 23/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol TypeDelegate:class {
    
    func selectedType(type:String)
    
}


class SelectTypeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var typeArray = [String]()
    var isType = false
    weak var delegate:TypeDelegate?
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"CellIdentifier",for : indexPath)
        
        cell.textLabel?.text = typeArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isType{
            let type = typeArray[indexPath.row]
            delegate?.selectedType(type: type)
            dismiss(animated: true, completion: nil)
        }
       
        
        
    }

  

}
