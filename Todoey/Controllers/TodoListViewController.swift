//
//  ViewController.swift
//  Todoey
//
//  Created by Rajneesh Biswal on 24/02/19.
//  Copyright © 2019 Rajneesh Biswal. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [ItemModel]()

        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
//    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let item1 = ItemModel()
        item1.itemName = "Naturals"
        item1.itemStatus = true
        
        let item2 = ItemModel()
        item2.itemName = "Real"
        item2.itemStatus = true
        
        
        let item3 = ItemModel()
        item3.itemName = "PaperBoat"
        item3.itemStatus = true
        
        let item4 = ItemModel()
        item4.itemName = "MinuteMaid"
        item4.itemStatus = true
        
        itemArray.append(item1)
        itemArray.append(item2)
        itemArray.append(item3)
        itemArray.append(item4)

        
//        if let items = defaults.array(forKey: "TodoListArray") as? [ItemModel] {
//        itemArray = items
//        }
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].itemName
        
        cell.accessoryType = itemArray[indexPath.row].itemStatus ? .checkmark : .none
        
        if itemArray[indexPath.row].itemStatus == true
        {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].itemStatus = !itemArray[indexPath.row].itemStatus

        saveItems()
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addNewItemPressed(_ sender: UIBarButtonItem) {
        
        var text = UITextField()
        
        let alert = UIAlertController.init(title: "Add Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction.init(title: "Add" , style: .default) { (action) in
            
            let item5 = ItemModel()
            item5.itemName = text.text!
            
            self.itemArray.append(item5)
            
            self.saveItems()
//            self.defaults .setValue(self.itemArray, forKey: "TodoListArray")
            
        }
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Add Item placeholder"
            text = alertTextField
        }
        alert.addAction(alertAction)
        present(alert, animated: true) {
            
        }
    }
    
    func saveItems()
    {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encountered \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([ItemModel].self, from: data)
            } catch {
                
            }
        }
    }
}

