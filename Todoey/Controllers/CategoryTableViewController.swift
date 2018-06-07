//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Administrator on 5/31/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
        }
        
    }
    
    //MARK: -Model Manupulation Methods
    func save(category: Category){
        //save added item into user defaults
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving context\(error)")
        }
        tableView.reloadData()
    }
    func loadCategories(){
        
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        
//        do {
//            categories = try context.fetch(request)
//        }catch{
//            print("Error fetching data from categories \(error)")
//        }
//        tableView.reloadData()
    }
    
    //MARK: -Add New categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
     
        
        var textField = UITextField()
        let alert = UIAlertController(title: " Add New Category", message: "",preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) {(action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.save(category: newCategory)
            
        }
        alert.addTextField { (field) in
            
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}
