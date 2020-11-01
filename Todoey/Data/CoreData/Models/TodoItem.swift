//
//  TodoItem.swift
//  Todoey
//
//  Created by Akimov on 10/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct TodoItemDTO: Codable {
    let title: String
    var isDone: Bool
}
