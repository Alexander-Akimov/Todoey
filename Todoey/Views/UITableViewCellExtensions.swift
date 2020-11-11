//
//  UITableViewCellExtensions.swift
//  Todoey
//
//  Created by Akimov on 10/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

extension UITableViewCell {
    func configure(_ todoItem: TodoItemDTO) {
        self.textLabel?.text = todoItem.title
        self.accessoryType = todoItem.isDone ? .checkmark : .none
        setTextColor()
    }

    func configure(_ item: CategoryDTO) {
        self.textLabel?.text = item.name
        self.backgroundColor = UIColor(hexString: item.bgColorHex)
        setTextColor()
    }
    
    private func setTextColor() {
        if let bgColor = self.backgroundColor {
            self.textLabel?.textColor = ContrastColorOf(bgColor, returnFlat: true)
        }
    }

}
