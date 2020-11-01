//
//  TodoItem.swift
//  Todoey
//
//  Created by Akimov on 10/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol DtoProtocol { }

struct TodoItemDTO: Codable, DtoProtocol {
    let title: String
    var isDone: Bool
    var dateCreated: Date?
}

extension TodoItemDTO {
    static var empty = TodoItemDTO(title: "No Items Added", isDone: false, dateCreated: nil)
}
