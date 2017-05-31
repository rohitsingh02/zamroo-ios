//
//  NoOfFloorViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 23/09/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit


protocol NoOfFloorDelegate:class {
    
    func selectedNoOfFloor(noOfFloor:String)
    func selectedTotalFloor(totalFloor : String)
}


class NoOfFloorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var floorArray = [String]()
    var isTotalFloor = false
    weak var delegate:NoOfFloorDelegate?
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return floorArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"CellIdentifier",for : indexPath)
        
        cell.textLabel?.text = floorArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isTotalFloor{
            let totalArray = floorArray[indexPath.row]
         delegate?.selectedTotalFloor(totalFloor: totalArray)
            dismiss(animated: true, completion: nil)
        }
        else{
            let totalArray = floorArray[indexPath.row]
            delegate?.selectedNoOfFloor(noOfFloor: totalArray)
            dismiss(animated: true, completion: nil)
        }
    }
}
