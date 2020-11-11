//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class TodoListCDViewController: SwipeTableViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    private let dataService = ItemsDataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.loadItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let colorHex = dataService.selectedCategory?.bgColorHex {
            title = dataService.selectedCategory!.name
            super.configureNavBar(bgColor: colorHex)
            self.configureSearchBar(bgColor: colorHex)
        }
    }

    private func configureSearchBar(bgColor: String) {
        if #available(iOS 11.0, *) {
            searchBar.barTintColor = UIColor(hexString: bgColor)
            
        }
        if #available(iOS 13.0, *) {
            searchBar.barTintColor = UIColor(hexString: bgColor)
            searchBar.searchTextField.backgroundColor = .white
        }
    }

    func setCategory(category: Category) {
        dataService.selectedCategory = category
    }

    //MARK: - Add New todo Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: K.AddItem.title, message: K.AddItem.emptyMessage, preferredStyle: .alert)

        let action = UIAlertAction(title: K.AddItem.alertTitle, style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert

            let newItem = TodoItemDTO(title: textField.text!, isDone: false, dateCreated: Date())
            self.dataService.add(newItem)

            self.tableView.reloadData()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = K.AddItem.placeholder
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }

    @objc func dismissOnTapOutside() {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - Delete on swipe
    override func onDeleteAction(at index: Int) {
        self.dataService.delete(at: index)
    }
}

//MARK: - TableView DataSource Methods
extension TodoListCDViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let todoItemCell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = dataService.get(by: indexPath.row)

        let mainColor = UIColor(hexString: dataService.selectedCategory!.bgColorHex)

        todoItemCell.backgroundColor = mainColor?.darken(byPercentage: CGFloat(Float(indexPath.row) / Float(dataService.count)))

        todoItemCell.configure(item)

        return todoItemCell
    }
}

//MARK: - TableView Delegate Methods
extension TodoListCDViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var item = dataService.get(by: indexPath.row)

        item.isDone = !item.isDone

        dataService.update(item, at: indexPath.row)

        tableView.reloadRows(at: [indexPath], with: .middle)
        tableView.deselectRow(at: indexPath, animated: true)

        /*
         dataService.delete(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
         */
    }
}

//MARK: - Search bar methods
extension TodoListCDViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dataService.searchItems(by: searchBar.text!)

        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            dataService.loadItems()

            tableView.reloadData()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
