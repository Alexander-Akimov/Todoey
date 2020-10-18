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
}

extension TodoListViewController {

    //MARK: - TableView DataSourceMethods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persistence.getItemsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let todoItemCell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)

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

