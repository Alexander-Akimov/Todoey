//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Akimov on 11/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit
import ChameleonFramework

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70.0
        tableView.separatorStyle = .none
    }

    func configureNavBar(bgColor: String) {

        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation Controller does not exist")
        }

        guard let bgUIColor = UIColor(hexString: bgColor) else { return }
        let contrColor = ContrastColorOf(bgUIColor, returnFlat: true)
        
        navBar.prefersLargeTitles = true
        navBar.tintColor = contrColor

        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: contrColor]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: contrColor]
            navBarAppearance.backgroundColor = bgUIColor
            //UIColor(hexString: "0A84FF")
            navBar.standardAppearance = navBarAppearance
            navBar.scrollEdgeAppearance = navBarAppearance
        }

        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.barTintColor = bgUIColor
            self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: contrColor]
            //self.navigationController?.view.backgroundColor = .white
        }
    }

    func onDeleteAction(at index: Int) {
        preconditionFailure("This method must be overridden")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellName, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        return cell
    }

//MARK: - Sewipe Cell Delegat Methods

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.onDeleteAction(at: indexPath.row)
            action.fulfill(with: .delete)
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive

        return options
    }
}
