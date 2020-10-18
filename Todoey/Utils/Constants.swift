//
//  Constants.swift
//  Todoey
//
//  Created by Akimov on 10/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct K {
    
    static let cellIdentifier = "TodoItemCell"
    static let plistFileName = "Items.plist"
    
    struct AddItem {
        static let title = "Add New Todoey item"
        static let alertTitle = "Add Item"
        static let placeholder = "Create new item"
        static let emptyMessage = ""
    }
    
    struct Errors {
        static let encode = "Error encoding item array, %s"
        static let decode = "Error decoding item array, %s"
    }
}
