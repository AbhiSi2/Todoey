//
//  ViewController.swift
//  Todoey
//
//  Created by Rajneesh Biswal on 24/02/19.
//  Copyright © 2019 Rajneesh Biswal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Naturals","Real","PaperBoat"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
        itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addNewItemPressed(_ sender: UIBarButtonItem) {
        
        var text = UITextField()
        
        let alert = UIAlertController.init(title: "Add Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction.init(title: "Add" , style: .default) { (action) in
            
            self.itemArray.append(text.text!)
            self.defaults .setValue(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add Item placeholder"
            text = alertTextField
        }
        alert.addAction(alertAction)
        present(alert, animated: true) {
            
        }
    }
}

