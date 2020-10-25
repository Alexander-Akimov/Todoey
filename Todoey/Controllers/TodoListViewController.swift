//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    private let persistence = DataPersistenceService()

    override func viewDidLoad() {
        super.viewDidLoad()
        persistence.loadItems()
    }

    //MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: K.AddItem.title, message: K.AddItem.emptyMessage, preferredStyle: .alert)

        let action = UIAlertAction(title: K.AddItem.alertTitle, style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert
            
            let newItem = TodoItemDTO(title: textField.text!, isDone: false)
            self.persistence.addItem(newItem)
            self.persistence.saveItems()

            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.AddItem.placeholder
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}

extension TodoListViewController {

    //MARK: - TableView DataSourceMethods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persistence.getItemsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let todoItemCell = tableView.dequeueReusableCell(withIdentifier: K.todoItemCell, for: indexPath)

        todoItemCell.configure(persistence.getItem(by: indexPath.row))

        return todoItemCell
    }
}


extension TodoListViewController {
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let item = persistence.getItem(by: indexPath.row)

        let updatedItem = TodoItemDTO(title: item.title, isDone: !item.isDone)

        persistence.updateItem(updatedItem, at: indexPath.row)

        persistence.saveItems()

        tableView.reloadRows(at: [indexPath], with: .middle)
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.accessoryType = cell?.accessoryType == .checkmark ? .none : .checkmark

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

