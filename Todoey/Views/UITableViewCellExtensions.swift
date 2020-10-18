//
//  UITableViewCellExtensions.swift
//  Todoey
//
//  Created by Akimov on 10/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    func configure(_ todoItem: TodoItemDTO) {
        self.textLabel?.text = todoItem.title
        self.accessoryType = todoItem.isDone ? .checkmark : .none
    }
}
