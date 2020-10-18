//
//  TranslationService.swift
//  Todoey
//
//  Created by Akimov on 10/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreData

class TranslationService {

    func translate(from item: Item?) -> TodoItemDTO? {
        guard let item = item else { return nil }

        return TodoItemDTO(title: item.title!, isDone: item.done)
    }

    func translate(from dto: TodoItemDTO?, with context: NSManagedObjectContext) -> Item? {
        guard let dto = dto else { return nil }

        let item = Item(context: context)
        item.title = dto.title
        item.done = dto.isDone

        return item
    }

    func toUnsavedCoreData(from dtos: [TodoItemDTO], with context: NSManagedObjectContext) -> [Item] {
        let items = dtos.compactMap { dto in translate(from: dto, with: context) }

        return items
    }

    func toTodoItemsDTOs(from items: [Item]) -> [TodoItemDTO] {
        let dtos = items.compactMap { translate(from: $0) }

        return dtos
    }
}
