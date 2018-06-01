//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Administrator on 5/31/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import CoreData


class CategoryTableViewController: UITableViewController {

    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
    }
    //MARK: -TableView Datasource Methods
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    //MARK: -TableView Delegate Methods
    
    //MARK: -Add New categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     
        
        var textField = UITextField()
        let alert = UIAlertController(title: " Add New Category", message: "",preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {(action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            
        }
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: -Model Manupulation Methods
    func saveItems(){
        //save added item into user defaults
        
        do{
            
            try context.save()
        }catch{
            print("Error saving context\(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        do {
            itemArray = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
}
