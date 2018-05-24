//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        // load data from user defaults
        let newItem = item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)

        let newItem3 = item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)

        
        
       
        
        
    }
    
    
    // tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellhi", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //Ternary operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark: .none
        
        return cell
    }
    
    //Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // set the checkmark state once it has been clicked
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: " Add New Todoey Item", message: "",preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
//            // what will happen once the user clicks the Add Item button on our UIAlert
//
            let newItem = item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()

            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print("alertText get triggered")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems(){
        //save added item into user defaults
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData()
    }
    
    
}

