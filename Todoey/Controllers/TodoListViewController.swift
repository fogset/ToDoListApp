//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Administrator. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    // tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellhi", for: indexPath)
        
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            
            //Ternary operator ==>
            //value = condition ? valueIfTrue : valueIfFalse
            
            cell.accessoryType = item.done ? .checkmark: .none
        }else{
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write {
                item.done = !item.done
                }
            }catch{
                print("Error saving done status, \(error)")
            }
        }
        tableView.reloadData()
        //context.delete(todoItems[indexPath.row])
        //todoItems.remove(at: indexPath.row)
        
        // set the checkmark state once it has been clicked
        //todoItems[indexPath.row].setValue("Completed", forKey: "title")
        //todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
        
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: " Add New Todoey Item", message: "",preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {(action) in
           // what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                }catch{
                    print("Error saving new items, \(error)")
                }
                
            }
            
            self.tableView.reloadData()
   
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print("alertText get triggered")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: -Model Manupulation Methods
   
    
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
    
        tableView.reloadData()
    }
   
    
}
//MARK: -Search bar methods
//extension TodoListViewController: UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//    //show the entire tableview when delete search
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//}
//
