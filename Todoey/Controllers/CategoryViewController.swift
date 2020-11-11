//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Akimov on 10/19/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!

    private let dataService = CategoriesDataService()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.loadItems()

        configurationBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.configureNavBar(bgColor: K.CategoryColors.navBarColor)
    }

    private func configurationBindings() {
        //        addButton.rx.tap.subscribe({
        //            t in print(t)
        //        }).disposed(by: disposeBag)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()

        let alert = UIAlertController(title: K.AddCat.title, message: K.AddCat.emptyMessage, preferredStyle: .alert)

        let action = UIAlertAction(title: K.AddCat.alertTitle, style: .default) { (action) in
            //what will happen once the user clicks the Add Item Button on our UIAlert
            let randomColorHex = UIColor.randomFlat().hexValue()
            let newCat = CategoryDTO(name: textField.text!, bgColorHex: randomColorHex)
            self.dataService.add(newCat)

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

    override func onDeleteAction(at index: Int) {
        // handle action by updating model with deletion
        self.dataService.delete(at: index)
    }
}

//MARK: - TableView DataSource Methods
extension CategoryViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        let item = dataService.get(by: indexPath.row)

        cell.configure(item)

        return cell
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
            if let category = dataService.getObject(by: indexPath.row) {
                destinationVC.setCategory(category: category)
            }
        }
    }
}
