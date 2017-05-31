//
//  MultipleColumnSelectedViewController.swift
//  Zamroo
//
//  Created by Rohit Singh on 19/10/16.
//  Copyright © 2016 Rohit Singh. All rights reserved.
//

import UIKit

protocol MultipleSelectionDelegate:class {
    
    func multipleSelection1(selectedItemsArray:[String])
    func multipleSelection2(selectedItemsArray:[String])
    
}



class MultipleColumnSelectedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var itemsArray = [String]()
    var ismultipleSelection = false
    weak var delegate:MultipleSelectionDelegate?
    var multipleSelectionArray1 = [String]()
    var multipleSelectionArray2 = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier:"multipleCellIdentifier",for : indexPath) as! MultipleSelectionTableViewCell
        
        cell.titleLabel.text = itemsArray[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        if ismultipleSelection{
            
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark;
            multipleSelectionArray1.append(itemsArray[indexPath.row])
        }else{
            
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark;
            multipleSelectionArray2.append(itemsArray[indexPath.row])
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
    
        if ismultipleSelection{
            if let index = multipleSelectionArray1.index(of: itemsArray[indexPath.row]) {
                multipleSelectionArray1.remove(at: index)
            }
        }
        else{
            if let index = multipleSelectionArray1.index(of: itemsArray[indexPath.row]) {
                multipleSelectionArray1.remove(at: index)
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: AnyObject) {
       
        if ismultipleSelection{
          LocalStore.saveMultipleSelectionArray1(multipleSelectionArray1)
            delegate?.multipleSelection1(selectedItemsArray: multipleSelectionArray1)
        }
        else{
         LocalStore.saveMultipleSelectionArray1(multipleSelectionArray2)
            delegate?.multipleSelection2(selectedItemsArray: multipleSelectionArray2)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
