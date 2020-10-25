//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Akimov on 10/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {

    private let dataService = CategoriesDataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.loadItems()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: K.AddCat.title, message: K.AddCat.emptyMessage, preferredStyle: .alert)

        let action = UIAlertAction(title: K.AddCat.alertTitle, style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert

            let newCat = CategoryDTO(name: textField.text!)
            self.dataService.addItem(newCat)
            self.dataService.saveItems()

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



}

//MARK: - TableView DataSource Methods
extension CategoryViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.getItemsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let categoryCell = tableView.dequeueReusableCell(withIdentifier: K.categoryCell, for: indexPath)

        let item = dataService.getItem(by: indexPath.row)

        categoryCell.configure(item)

        return categoryCell
    }
}

//MARK: - TableView Delegate Methods
extension CategoryViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {



        //dataService.updateItem(item, at: indexPath.row)

        performSegue(withIdentifier: "goToItems", sender: self)

        //tableView.reloadRows(at: [indexPath], with: .middle)
        //tableView.deselectRow(at: indexPath, animated: true)

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        let destinationVC = segue.destination as! TodoListCDViewController

        if let indexPath = tableView.indexPathForSelectedRow {
            if let category = dataService.getEntity(by: indexPath.row) {
                destinationVC.setCategory(category: category)
            }
        }
    }
}

